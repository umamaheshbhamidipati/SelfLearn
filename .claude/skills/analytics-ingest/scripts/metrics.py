#!/usr/bin/env python3
"""analytics-ingest: keep docs/metrics.csv complete and honest.

  metrics.py due    [--today YYYY-MM-DD]      which readings are due, missed or still to come
  metrics.py post   --video V --platform P --date YYYY-MM-DD [--url U] [--project DIR] [--notes N]
  metrics.py add    --video V --platform P [--age 3d] [--measured-on YYYY-MM-DD] [--views N] ...
  metrics.py report [--today YYYY-MM-DD]      latest numbers against the targets and the gate

Rules built in: rows are only ever appended; one row per video + platform + age; unknown cells stay
empty; a video must be registered in docs/posts.csv before it can be measured. Standard library only.
"""
import argparse
import csv
import datetime as dt
import pathlib
import re
import statistics
import sys

COLS = ["date_posted", "video", "platform", "measured_on", "age", "views", "avg_watch_s", "pct_viewed",
        "swipe_away_pct", "shares", "saves", "follows_subs", "likes", "credits_spent", "notes"]
POST_COLS = ["video", "platform", "date_posted", "url", "project", "notes"]
PLATFORMS = ("youtube", "instagram", "facebook")
# checkpoint in days -> how many days late a reading may be and still carry that label
CHECKPOINTS = {1: 1, 3: 1, 7: 2, 28: 5}
# Targets and gate from docs/roadmap-2026-27.md, Quarter 1. Change them there first, then here.
IG_AVG_WATCH_TARGET_S = 8
YT_STAYED_TARGET_PCT = 40
GATE_MIN_POSTS = 30
GATE_MEDIAN_VIEWS = 1000
GATE_STAYED_PCT = 35


def root() -> pathlib.Path:
    p = pathlib.Path(__file__).resolve()
    for parent in p.parents:
        if (parent / "docs" / "metrics.csv").exists():
            return parent
    sys.exit("docs/metrics.csv not found above this script")


def read(path: pathlib.Path) -> list[dict]:
    if not path.exists():
        return []
    with path.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def append(path: pathlib.Path, cols: list[str], row: dict) -> None:
    new = not path.exists()
    if not new and path.read_bytes()[-1:] not in (b"\n", b""):
        with path.open("a", encoding="utf-8") as f:
            f.write("\n")
    with path.open("a", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=cols, lineterminator="\n")
        if new:
            w.writeheader()
        w.writerow({c: row.get(c, "") for c in cols})


def day(s: str) -> dt.date:
    try:
        return dt.date.fromisoformat(s)
    except ValueError:
        sys.exit(f"bad date '{s}': use YYYY-MM-DD")


def seconds(s: str) -> str:
    """'0:25' -> '25', '1:05' -> '65', '4' -> '4', '4.5' -> '4.5'."""
    s = s.strip().rstrip("s").strip()
    m = re.fullmatch(r"(\d+):(\d{1,2})", s)
    if m:
        return str(int(m.group(1)) * 60 + int(m.group(2)))
    if re.fullmatch(r"\d+(\.\d+)?", s):
        return s
    sys.exit(f"bad watch time '{s}': use seconds (25) or m:ss (0:25)")


def number(name: str, s: str, lo: float, hi: float, whole: bool = False) -> str:
    s = s.strip().rstrip("%").replace(",", "")
    try:
        v = float(s)
    except ValueError:
        sys.exit(f"--{name}: '{s}' is not a number. Leave the option out if the figure was not shown")
    if not lo <= v <= hi:
        sys.exit(f"--{name}: {v} is outside {lo}-{hi}. Re-read the screen")
    if whole and v != int(v):
        sys.exit(f"--{name}: expected a whole number, got {s}")
    return str(int(v)) if v == int(v) else s


def num(s: str):
    try:
        return float(s)
    except (TypeError, ValueError):
        return None


def age_days(age: str):
    m = re.fullmatch(r"(\d+)d", age or "")
    return int(m.group(1)) if m else None


def cmd_post(a, R):
    posts = read(R / "docs/posts.csv")
    if a.platform not in PLATFORMS:
        sys.exit(f"platform must be one of {PLATFORMS}")
    if any(p["video"] == a.video and p["platform"] == a.platform for p in posts):
        sys.exit(f"{a.video} on {a.platform} is already registered in docs/posts.csv")
    day(a.date)
    append(R / "docs/posts.csv", POST_COLS, {"video": a.video, "platform": a.platform, "date_posted": a.date,
                                               "url": a.url or "", "project": a.project or "", "notes": a.notes or ""})
    print(f"Registered {a.video} on {a.platform}, posted {a.date}")


def cmd_add(a, R):
    posts = read(R / "docs/posts.csv")
    rows = read(R / "docs/metrics.csv")
    post = next((p for p in posts if p["video"] == a.video and p["platform"] == a.platform), None)
    if not post:
        known = sorted({f"{p['video']}/{p['platform']}" for p in posts})
        sys.exit(f"{a.video} on {a.platform} is not in docs/posts.csv. Register it with 'post' first.\nKnown: {', '.join(known)}")
    posted = day(post["date_posted"])
    measured = day(a.measured_on) if a.measured_on else dt.date.today()
    if measured < posted:
        sys.exit(f"measured on {measured} is before the post date {posted}")
    real = (measured - posted).days
    age = a.age or f"{real}d"
    if not re.fullmatch(r"\d+[hd]|baseline", age):
        sys.exit("age must look like 3h, 1d, 7d or baseline")
    d = age_days(age)
    if d is not None and abs(d - real) > CHECKPOINTS.get(d, 0):
        sys.exit(f"age {age} does not fit the dates: posted {posted}, measured {measured} = {real} days. "
                 f"Use --age {real}d; a late reading is not a {age} reading")
    if any(r["video"] == a.video and r["platform"] == a.platform and r["age"] == age for r in rows):
        sys.exit(f"a {age} row for {a.video} on {a.platform} already exists. Past rows are never edited")
    row = {"date_posted": post["date_posted"], "video": a.video, "platform": a.platform,
           "measured_on": measured.isoformat(), "age": age, "notes": a.notes or ""}
    if a.views is not None: row["views"] = number("views", a.views, 0, 1e10, True)
    if a.avg_watch is not None: row["avg_watch_s"] = seconds(a.avg_watch)
    if a.pct_viewed is not None: row["pct_viewed"] = number("pct-viewed", a.pct_viewed, 0, 1000)
    if a.swipe_away is not None: row["swipe_away_pct"] = number("swipe-away", a.swipe_away, 0, 100)
    if a.stayed is not None:
        if a.swipe_away is not None:
            sys.exit("give --stayed or --swipe-away, not both")
        row["swipe_away_pct"] = number("stayed", str(round(100 - float(number("stayed", a.stayed, 0, 100)), 1)), 0, 100)
    for opt, col in (("shares", "shares"), ("saves", "saves"), ("follows", "follows_subs"), ("likes", "likes"),
                     ("credits", "credits_spent")):
        v = getattr(a, opt)
        if v is not None:
            row[col] = number(opt, v, 0, 1e10, True)
    filled = [c for c in COLS[5:14] if row.get(c)]
    if not filled:
        sys.exit("no figures given. Log nothing you could not read")
    append(R / "docs/metrics.csv", COLS, row)
    print(f"Added: {a.video} / {a.platform} / {age} / measured {measured}: " + ", ".join(f"{c}={row[c]}" for c in filled))


def cmd_due(a, R):
    today = day(a.today) if a.today else dt.date.today()
    posts, rows = read(R / "docs/posts.csv"), read(R / "docs/metrics.csv")
    have = {(r["video"], r["platform"], r["age"]) for r in rows}
    due, missed, coming, scheduled = [], [], [], []
    for p in posts:
        posted = day(p["date_posted"])
        key = f"{p['video']} / {p['platform']}"
        if posted > today:
            scheduled.append(f"{key}: goes out {posted}")
            continue
        if any(r["video"] == p["video"] and r["platform"] == p["platform"] and r["age"] == "baseline" for r in rows):
            continue  # a baseline post from before the schedule existed: nothing is due for it
        real = (today - posted).days
        for cp, late in CHECKPOINTS.items():
            if (p["video"], p["platform"], f"{cp}d") in have:
                continue
            if real < cp:
                coming.append(f"{key}: {cp}d reading on {posted + dt.timedelta(days=cp)}")
                break
            if real <= cp + late:
                due.append(f"{key}: {cp}d reading (posted {posted}, day {real})  ->  add --age {cp}d")
            else:
                missed.append(f"{key}: {cp}d reading (window closed {posted + dt.timedelta(days=cp + late)})")
        last = max((age_days(r["age"]) or 0 for r in rows if r["video"] == p["video"] and r["platform"] == p["platform"]), default=-1)
        if any(m.startswith(key + ":") for m in missed) and real > last and not any(d.startswith(key + ":") for d in due):
            due.append(f"{key}: take a late reading now, labelled with its real age  ->  add --age {real}d")
    print(f"Readings as of {today}")
    for title, items in (("DUE NOW", due), ("MISSED (cannot be recovered; do not back-fill)", missed),
                         ("COMING", coming), ("SCHEDULED POSTS", scheduled)):
        print(f"\n{title}: {len(items)}")
        for i in items:
            print("  " + i)
    unreg = sorted({(r["video"], r["platform"]) for r in rows} - {(p["video"], p["platform"]) for p in posts})
    if unreg:
        print("\nIn metrics.csv but not in posts.csv: " + ", ".join(f"{v}/{p}" for v, p in unreg))
    return 1 if due else 0


def cmd_report(a, R):
    today = day(a.today) if a.today else dt.date.today()
    posts, rows = read(R / "docs/posts.csv"), read(R / "docs/metrics.csv")
    latest = {}
    for r in rows:
        k = (r["video"], r["platform"])
        if k not in latest or day(r["measured_on"]) >= day(latest[k]["measured_on"]):
            latest[k] = r
    print(f"Latest reading per post, as of {today}\n")
    print(f"{'video':<24}{'platform':<11}{'age':<9}{'views':>7}{'watch s':>9}{'stayed %':>10}{'shares':>8}{'saves':>7}{'subs':>6}")
    for (v, p), r in sorted(latest.items(), key=lambda kv: kv[1]["date_posted"]):
        sw = num(r["swipe_away_pct"])
        stayed = f"{100 - sw:.1f}" if sw is not None else ""
        print(f"{v:<24}{p:<11}{r['age']:<9}{r['views']:>7}{r['avg_watch_s']:>9}{stayed:>10}{r['shares']:>8}{r['saves']:>7}{r['follows_subs']:>6}")

    def pick(platform, col):
        # medians use readings taken at 3 days or later; a 3-hour or 1-day figure is not comparable
        return [x for x in (num(r[col]) for (v, p), r in latest.items()
                            if p == platform and (age_days(r["age"]) or 0) >= 3) if x is not None]

    print("\nAgainst the Quarter 1 targets (docs/roadmap-2026-27.md); readings of 3 days or older only")
    ig = pick("instagram", "avg_watch_s")
    print(f"  Instagram average watch: target {IG_AVG_WATCH_TARGET_S} s; "
          + (f"median of {len(ig)} post(s) = {statistics.median(ig):g} s" if ig else "no reading yet"))
    st = [100 - x for x in pick("youtube", "swipe_away_pct")]
    print(f"  YouTube stayed to watch: target {YT_STAYED_TARGET_PCT}%; "
          + (f"median of {len(st)} post(s) = {statistics.median(st):.1f}%" if st else "no reading yet"))
    saves = pick("instagram", "saves")
    print("  Instagram saves: target above 0; " + (f"best so far = {max(saves):g}" if saves else "no reading yet"))

    live = [p for p in posts if p["platform"] == "youtube" and day(p["date_posted"]) <= today]
    yv = pick("youtube", "views")
    print(f"\nGate (14 Feb 2027): {len(live)} of {GATE_MIN_POSTS} YouTube posts are out.")
    if yv:
        print(f"  Median views per Short = {statistics.median(yv):g} (gate {GATE_MEDIAN_VIEWS}); "
              + (f"stayed = {statistics.median(st):.1f}% (gate {GATE_STAYED_PCT}%)" if st else "stayed: no reading"))
    if len(live) < GATE_MIN_POSTS:
        print("  Too few posts to judge. Do not draw a conclusion from these numbers yet.")
    n = len([r for r in rows if r["age"] != "baseline"])
    print(f"\n{n} reading(s) in total. With a few hundred views per post, most differences are noise: say 'inconclusive' when unsure.")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("due"); s.add_argument("--today")
    s = sub.add_parser("report"); s.add_argument("--today")
    s = sub.add_parser("post")
    s.add_argument("--video", required=True); s.add_argument("--platform", required=True)
    s.add_argument("--date", required=True); s.add_argument("--url"); s.add_argument("--project"); s.add_argument("--notes")
    s = sub.add_parser("add")
    s.add_argument("--video", required=True); s.add_argument("--platform", required=True)
    s.add_argument("--age"); s.add_argument("--measured-on")
    for o in ("views", "avg-watch", "pct-viewed", "swipe-away", "stayed", "shares", "saves", "follows", "likes", "credits", "notes"):
        s.add_argument("--" + o)
    a = ap.parse_args()
    R = root()
    sys.exit({"due": cmd_due, "report": cmd_report, "post": cmd_post, "add": cmd_add}[a.cmd](a, R) or 0)


if __name__ == "__main__":
    main()
