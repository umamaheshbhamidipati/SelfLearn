#!/usr/bin/env python3
"""reference-teardown: measure a video (a reference Short/Reel, or one of ours) so its structure can be studied.

  teardown.py <video> [--out DIR] [--slug NAME] [--threshold 0.15] [--min-shot 0.4]
                      [--drop 17.04,27.04] [--add 15.5]     correct the cut list after looking at the sheets

Writes into DIR (default ~/.cache/selflearn-refs/<slug>/, outside the repo and outside the Drive backup):
  facts.json      duration, size, letterbox, loudness, silent gaps, cut times, shot list, rhythm figures
  hook.jpg        the first 3 seconds at 4 frames a second (12 frames, left to right)
  shots-N.jpg     one labelled frame from the middle of every shot
  overview.jpg    the whole video at up to 2 frames a second
  teardown.md     the measured tables, with empty columns for Claude to fill in after LOOKING at the sheets

It measures; it does not judge. The source video is never copied. Needs ffmpeg and ffprobe on PATH.
"""
import argparse
import json
import math
import pathlib
import re
import statistics
import subprocess
import sys


def run(cmd, check=True):
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, errors="replace")
    if check and p.returncode != 0:
        sys.exit(f"command failed: {' '.join(cmd[:6])} ...\n{p.stderr[-600:]}")
    return p


def probe(video):
    j = json.loads(run(["ffprobe", "-v", "error", "-show_format", "-show_streams", "-of", "json", video]).stdout)
    v = next((s for s in j["streams"] if s["codec_type"] == "video"), None)
    if not v:
        sys.exit("no video stream in this file")
    a = next((s for s in j["streams"] if s["codec_type"] == "audio"), None)
    n, d = (v.get("avg_frame_rate") or v["r_frame_rate"]).split("/")
    return {"duration": float(j["format"]["duration"]), "width": int(v["width"]), "height": int(v["height"]),
            "fps": round(float(n) / float(d or 1), 2) if float(d or 1) else 0.0, "has_audio": bool(a)}


def cuts(video, threshold, min_shot, duration, crop=""):
    # crop to the picture first: black letterbox bars dilute the scene score until no cut is found
    err = run(["ffmpeg", "-hide_banner", "-nostats", "-i", video, "-an",
               "-vf", f"{crop}scale=320:-2,select='gt(scene,{threshold})',showinfo", "-f", "null", "-"]).stderr
    raw = sorted(float(t) for t in re.findall(r"pts_time:([0-9.]+)", err))
    out = []
    for t in raw:
        if t < min_shot or duration - t < min_shot:
            continue
        if out and t - out[-1] < min_shot:
            continue  # a flash or a transition frame, not a new shot
        out.append(round(t, 2))
    return out, len(raw)


def letterbox(video, w, h, duration):
    err = run(["ffmpeg", "-hide_banner", "-nostats", "-ss", str(duration * 0.2), "-t", str(min(8, duration * 0.6)),
               "-i", video, "-an", "-vf", "cropdetect=24:2:0", "-f", "null", "-"], check=False).stderr
    found = re.findall(r"crop=(\d+):(\d+):(\d+):(\d+)", err)
    if not found:
        return None
    cw, ch, cx, cy = map(int, statistics.mode(found))
    if cw >= 0.95 * w and ch >= 0.95 * h:
        return None
    return {"picture_w": cw, "picture_h": ch, "x": cx, "y": cy, "screen_used_pct": round(100 * cw * ch / (w * h))}


def audio(video):
    err = run(["ffmpeg", "-hide_banner", "-nostats", "-i", video, "-vn",
               "-af", "silencedetect=noise=-45dB:d=0.4,ebur128", "-f", "null", "-"], check=False).stderr
    lufs = re.findall(r"\bI:\s+(-?[0-9.]+) LUFS", err)
    starts = [float(x) for x in re.findall(r"silence_start: (-?[0-9.]+)", err)]
    ends = [float(x) for x in re.findall(r"silence_end: (-?[0-9.]+)", err)]
    gaps = [[round(max(s, 0), 2), round(e, 2)] for s, e in zip(starts, ends)]
    return {"integrated_lufs": float(lufs[-1]) if lufs else None, "silent_gaps": gaps}


def tile(frames_glob_start, count, pattern, cols, out):
    rows = math.ceil(count / cols)
    run(["ffmpeg", "-v", "error", "-y", "-framerate", "1", "-start_number", str(frames_glob_start), "-i", pattern,
         "-frames:v", "1", "-vf", f"tile={cols}x{rows}", "-update", "1", out])


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("video"); ap.add_argument("--out"); ap.add_argument("--slug")
    ap.add_argument("--threshold", type=float, default=0.15); ap.add_argument("--min-shot", type=float, default=0.4)
    ap.add_argument("--drop", default="", help="comma-separated cut times to remove (false cuts)")
    ap.add_argument("--add", default="", help="comma-separated cut times to add (missed cuts)")
    a = ap.parse_args()
    video = str(pathlib.Path(a.video).expanduser().resolve())
    if not pathlib.Path(video).is_file():
        sys.exit(f"not a file: {a.video}")
    slug = a.slug or re.sub(r"[^a-z0-9]+", "-", pathlib.Path(video).stem.lower()).strip("-")[:40]
    out = pathlib.Path(a.out).expanduser() if a.out else pathlib.Path.home() / ".cache/selflearn-refs" / slug
    out.mkdir(parents=True, exist_ok=True)
    tmp = out / "_frames"; tmp.mkdir(exist_ok=True)
    for f in tmp.glob("*.jpg"):
        f.unlink()

    p = probe(video)
    dur = p["duration"]
    lb0 = letterbox(video, p["width"], p["height"], dur)
    crop = f"crop={lb0['picture_w']}:{lb0['picture_h']}:{lb0['x']}:{lb0['y']}," if lb0 else ""
    cut_times, raw_count = cuts(video, a.threshold, a.min_shot, dur, crop)
    drop = [float(x) for x in a.drop.split(",") if x.strip()]
    add = [float(x) for x in a.add.split(",") if x.strip()]
    unmatched = [d for d in drop if not any(abs(t - d) <= 0.1 for t in cut_times)]
    if unmatched:
        sys.exit(f"--drop {unmatched}: no detected cut within 0.1 s. Detected: {cut_times}")
    cut_times = sorted([t for t in cut_times if not any(abs(t - d) <= 0.1 for d in drop)] + [t for t in add if 0 < t < dur])
    edges = [0.0] + cut_times + [round(dur, 2)]
    shots = [{"n": i + 1, "start": edges[i], "end": edges[i + 1], "length": round(edges[i + 1] - edges[i], 2)}
             for i in range(len(edges) - 1)]
    lens = [s["length"] for s in shots]
    facts = {"file": pathlib.Path(video).name, "slug": slug, **p,
             "aspect": "9:16 vertical" if p["height"] > p["width"] * 1.6 else f"{p['width']}x{p['height']}",
             "letterbox": lb0,
             "audio": audio(video) if p["has_audio"] else None,
             "scene_threshold": a.threshold, "raw_scene_changes": raw_count, "cuts_dropped_by_hand": drop,
             "cuts_added_by_hand": add, "cuts": cut_times, "shots": shots,
             "rhythm": {"shots": len(shots), "average_s": round(statistics.mean(lens), 2),
                        "median_s": round(statistics.median(lens), 2), "shortest_s": min(lens), "longest_s": max(lens),
                        "first_cut_s": cut_times[0] if cut_times else None,
                        "cuts_in_first_3s": sum(1 for t in cut_times if t <= 3.0),
                        "cuts_per_10s": round(10 * len(cut_times) / dur, 1)}}
    (out / "facts.json").write_text(json.dumps(facts, indent=1), encoding="utf-8")

    # hook strip: first 3 s at 4 fps
    run(["ffmpeg", "-v", "error", "-y", "-t", "3", "-i", video, "-frames:v", "1",
         "-vf", f"{crop}fps=4,scale=200:-2,tile=12x1", "-update", "1", str(out / "hook.jpg")])
    # one labelled frame per shot, 40 shots per sheet
    for s in shots:
        mid = s["start"] + s["length"] / 2
        label = f"{s['n']}  {s['start']:.1f}-{s['end']:.1f}s"
        base = ["ffmpeg", "-v", "error", "-y", "-ss", f"{mid:.2f}", "-i", video, "-frames:v", "1"]
        dst = str(tmp / f"s{s['n']:04d}.jpg")
        r = run(base + ["-vf", f"{crop}scale=220:-2,drawtext=text='{label}':x=5:y=5:fontsize=17:fontcolor=white:box=1:boxcolor=black@0.65", dst], check=False)
        if r.returncode != 0:
            run(base + ["-vf", f"{crop}scale=220:-2", dst])
    sheets = []
    for i in range(0, len(shots), 40):
        n = min(40, len(shots) - i)
        name = f"shots-{i // 40 + 1}.jpg"
        tile(i + 1, n, str(tmp / "s%04d.jpg"), min(8, n), str(out / name))
        sheets.append(name)
    # overview: whole video, at most 2 fps and at most 80 frames
    fps = min(2.0, 80.0 / dur)
    frames = max(1, int(dur * fps))
    cols = 10
    run(["ffmpeg", "-v", "error", "-y", "-i", video, "-frames:v", "1",
         "-vf", f"{crop}fps={fps:.4f},scale=140:-2,tile={cols}x{math.ceil(frames / cols) + 1}", "-update", "1", str(out / "overview.jpg")])
    for f in tmp.glob("*.jpg"):
        f.unlink()
    tmp.rmdir()

    r = facts["rhythm"]; lb = facts["letterbox"]; au = facts["audio"]
    md = [f"# Teardown: {slug}", "",
          "Measured by `reference-teardown` (ffmpeg). Columns marked **fill** are for Claude to complete after looking at",
          "`hook.jpg`, the `shots-N.jpg` sheets and `overview.jpg`. Structure only: never copy footage, captions, music or characters.", "",
          "## Source (fill)", "- Link, creator, date viewed:", "- Public numbers on that date (views, likes, shares, comments):",
          "- Why the owner picked it (liked / disliked, in the owner's words):", "",
          "## Measured facts",
          f"- Length {dur:.1f} s, {p['width']}x{p['height']}, {p['fps']} fps, {facts['aspect']}.",
          "- Letterbox: " + (f"picture is {lb['picture_w']}x{lb['picture_h']}, using {lb['screen_used_pct']}% of the screen." if lb else "none found (full frame)."),
          "- Sound: " + ("no audio track." if not au else
                         f"{au['integrated_lufs']} LUFS integrated; " + (f"{len(au['silent_gaps'])} silent gap(s) of 0.4 s or more: {au['silent_gaps']}." if au["silent_gaps"] else "no silent gap of 0.4 s or more.")),
          f"- Rhythm: {r['shots']} shots; average {r['average_s']} s, median {r['median_s']} s, shortest {r['shortest_s']} s, longest {r['longest_s']} s.",
          f"- First cut at {r['first_cut_s']} s; {r['cuts_in_first_3s']} cut(s) in the first 3 s; {r['cuts_per_10s']} cuts per 10 s.",
          f"- Cut detection: scene threshold {a.threshold}"
          + (f"; dropped by hand {drop}" if drop else "") + (f"; added by hand {add}" if add else "")
          + ". A fast move inside a shot can show up as a cut, and a dissolve can be missed: check every cut on the sheets.", "",
          "## Hook (fill, from `hook.jpg`: 12 frames = the first 3 seconds)",
          "- First frame (what is it, is it the strongest image?):", "- What moves or changes in second 1:",
          "- First words heard or shown, and at what time (ask the owner for speech; read captions off the frames):",
          "- The promise or question that makes a viewer stay:", "",
          "## Shot list", "| # | Time | Length | What is on screen (**fill**) | Shot size (**fill**) | Carries into the next shot by (**fill**) |", "|---|---|---|---|---|---|"]
    md += [f"| {s['n']} | {s['start']:.1f}-{s['end']:.1f} | {s['length']:.1f} s | | | |" for s in shots]
    md += ["", "## Beat sheet (fill)", "| Beat | Time | What happens |", "|---|---|---|",
           "| Hook | | |", "| Setup | | |", "| Turn or reveal | | |", "| Payoff | | |", "| Ending / call to action | | |", "",
           "## Text and sound (fill)", "- On-screen text: language, where on the screen, how long each line stays:",
           "- Voice, music, natural sound (the owner must listen; say so if nobody has):", "",
           "## Against our last video (fill; run this script on ours too)",
           "| Measure | Reference | Ours |", "|---|---|---|",
           f"| Length | {dur:.1f} s | |", f"| Shots | {r['shots']} | |", f"| Median shot | {r['median_s']} s | |",
           f"| First cut | {r['first_cut_s']} s | |", f"| Cuts in first 3 s | {r['cuts_in_first_3s']} | |", "",
           "## What we take from it (fill)",
           "- Patterns seen (add each to `docs/reference-patterns.md` and raise its count):",
           "- One thing to test in our next video, as a one-variable experiment:", "- Not to copy:", ""]
    (out / "teardown.md").write_text("\n".join(md), encoding="utf-8")

    print(f"{slug}: {dur:.1f} s, {p['width']}x{p['height']}, {r['shots']} shots, median {r['median_s']} s, first cut {r['first_cut_s']} s")
    print("cuts at: " + (" ".join(f"{t:g}" for t in cut_times) or "none found"))
    print(f"output: {out}/  (facts.json, hook.jpg, {', '.join(sheets)}, overview.jpg, teardown.md)")


if __name__ == "__main__":
    main()
