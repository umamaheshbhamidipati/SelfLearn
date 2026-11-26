#!/usr/bin/env python3
"""The Last View: build the edit (shots, captions, audio) with one ffmpeg run.

Usage (from the project folder):  python3 -I timeline.py [--test] [--run]
  --test  480x270, 10 fps, full length (quick look)
  --run   actually run ffmpeg (otherwise just write files and print the command)
Writes media/work/captions.ass, media/work/phone.png, media/work/narration.wav.
"""
import subprocess, sys, re, os, shlex

TEST = "--test" in sys.argv
W, H = (480, 270) if TEST else (1920, 1080)
FPS = 10 if TEST else 25
XF = 0.5          # crossfade length (s)
LEAD = 2.4        # title over black before the first narration clip
GAP = 0.6         # silence between narration clips
TAIL = 3.0        # hold after the last line
FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
A = "media/audio"; I = "media/in"; WK = "media/work"

def dur(f):
    return float(subprocess.check_output(["ffprobe", "-v", "error", "-show_entries", "format=duration",
                                          "-of", "csv=p=0", f]).decode())

def gaps(f):
    """Pauses inside a clip: list of (silence_start, silence_end)."""
    out = subprocess.run(["ffmpeg", "-nostats", "-hide_banner", "-i", f, "-af",
                          "silencedetect=noise=-35dB:d=0.25", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    s = [float(x) for x in re.findall(r"silence_start: ([\d.]+)", out)]
    e = [float(x) for x in re.findall(r"silence_end: ([\d.]+)", out)]
    return [(a, b) for a, b in zip(s, e) if b < dur(f) - 0.05]

# Narration transcripts (main session, Gemini), one caption line per entry.
CAPS = {
 1: ["He opened his eyes. A white room.", "No doors, no windows, no way out.", "Just one chair and a timer.",
     "89… 88… 87…", "Then, he heard a woman's voice.", "“You have exactly 90 seconds.”",
     "He asked her, “Who are you?”", "She smiled. “You don't need to know.”",
     "And that's when the phone started ringing."],
 2: ["There was no signal, no number,", "just one word: “Me.”", "He answered. At first, silence,",
     "then he heard his own voice.", "“Don't trust her.”", "He looked at the woman. She hadn't moved.",
     "“Who was that?”", "She simply said, “You. Not yet.”"],
 3: ["Then, the room disappeared.", "For just one second, he saw a hospital.", "His mother was crying.",
     "A little boy was holding his hand.", "Doctors were screaming.", "And then, everything was gone.",
     "Back to the white room.", "He looked at her. “What was that?”", "She answered, “Your last memory.”",
     "He whispered, “I'm not dead.”", "She looked at him and said,", "“Not in your world.”"],
 4: ["Then, the phone rang again.", "This time, the screen said “Tomorrow.”",
     "He answered. A little girl's voice:", "“Daddy?”", "His face changed. “Who are you?”",
     "And then, she said something", "that made him stop breathing.", "“I'm the reason you chose to die.”"],
 5: ["He looked at the woman.", "“What does that mean?”", "She stepped closer, and finally",
     "she told him the truth.", "“You didn't die.”", "“You were deleted.”"],
 6: ["The room began disappearing.", "He screamed, “Who are you?”", "The woman didn't answer.",
     "She looked directly at you.", "“I'm the person watching your life.”", "7… 6… 5…",
     "“…and you're not watching this story.”", "4… 3…", "“You're remembering it.”", "2… 1."],
 7: ["And then, he opened his eyes.", "He was sitting in front of a phone,", "watching the exact same video.",
     "He stared at the screen and whispered,", "“I've already seen this.”"],
 8: [],   # shown as the end card instead
}

# Shots per clip: (clip-local start s, image, effect). effect: in/out = zoom direction, g = glitch,
# "black" = black frame, "phone" = the phone mock-up, "end" = end card.
SHOTS = {
 1: [(0, "img11", "in"), (8.6, "img14", "out"), (13.5, "img12", "in"), (19.3, "img03", "out"), (24.4, "img15", "in")],
 2: [(0, "img13", "out"), (5.8, "img07", "in"), (12.2, "img12", "out"), (16.6, "img06", "in")],
 3: [(0, "img08", "g"), (4.9, "img04", "g"), (15.4, "img05", "out"), (19.6, "img03", "in"), (22.5, "img13", "in"),
     (24.9, "img01", "in")],
 4: [(0, "img15", "out"), (6.4, "img17", "in"), (10.2, "img16", "out")],
 5: [(0, "img02", "in"), (3.0, "img09", "g")],
 6: [(0, "img08", "g"), (4.6, "img01", "in"), (11.6, "img10", "g"), (19.75, "black", "black")],
 7: [(0, "phone", "in"), (9.6, "img04", "in")],
 8: [(0, "end", "end")],
}
TRANS = {("img15", 3): "fadewhite", ("img08", 3): "fadewhite", ("img08", 6): "pixelize", ("img10", 6): "pixelize",
         ("black", 6): "fadeblack", ("phone", 7): "fadeblack", ("end", 8): "fadeblack", ("img09", 5): "pixelize"}

def ts(t):
    h, r = divmod(t, 3600); m, s = divmod(r, 60)
    return f"{int(h)}:{int(m):02d}:{s:05.2f}"

def caption_times(f, lines):
    """Align lines to runs of real speech segments (between pauses) by dynamic programming:
    each line gets a contiguous run whose length best matches its expected speaking time."""
    if not lines: return []
    d = dur(f); g = gaps(f)
    segs, t = [], 0.0
    for a, b in g:
        segs.append((t, a)); t = b
    segs.append((t, d))
    wt = lambda l: len(l) + 12 * len(re.findall(r"\d+", l))   # spoken numbers are slow
    n, m = len(lines), len(segs)
    if m < n:
        raise SystemExit(f"{f}: {m} speech segments < {n} caption lines")
    span = segs[-1][1] - segs[0][0]; tot = sum(wt(l) for l in lines)
    exp = [span * wt(l) / tot for l in lines]
    INF = float("inf")
    C = [[INF] * (m + 1) for _ in range(n + 1)]; P = [[0] * (m + 1) for _ in range(n + 1)]
    C[0][0] = 0
    for i in range(1, n + 1):
        for k in range(i, m + 1):
            for j in range(i - 1, k):
                if C[i-1][j] == INF: continue
                ln = segs[k-1][1] - segs[j][0]
                c = C[i-1][j] + (ln - exp[i-1]) ** 2 / max(exp[i-1], 0.5)
                if c < C[i][k]: C[i][k], P[i][k] = c, j
    out, k = [], m
    for i in range(n, 0, -1):
        j = P[i][k]; out.append((j, k)); k = j
    out.reverse()
    res = []
    for i, (j, k) in enumerate(out):
        st = 0.0 if i == 0 else segs[j][0] - 0.05
        en = d if i == n - 1 else segs[k-1][1] + 0.25
        res.append((st, en, lines[i]))
    return res

def main():
    os.makedirs(WK, exist_ok=True)
    clips = [f"{A}/a{n}.mpeg" for n in range(1, 9)]
    starts, t = [], LEAD
    for c in clips:
        starts.append(t); t += dur(c) + GAP
    total = t - GAP + TAIL
    pass

    # ---- captions (ASS) ----
    fs = int(H * 0.058)
    ass = ["[Script Info]", "ScriptType: v4.00+", f"PlayResX: {W}", f"PlayResY: {H}", "WrapStyle: 0", "",
           "[V4+ Styles]",
           "Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic,"
           " Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL,"
           " MarginR, MarginV, Encoding",
           f"Style: Cap,DejaVu Sans,{fs},&H00FFFFFF,&H00FFFFFF,&H00000000,&H80000000,-1,0,0,0,100,100,0,0,1,"
           f"{max(2, fs // 14)},{max(1, fs // 30)},2,{W // 12},{W // 12},{int(H * 0.06)},1",
           f"Style: End,DejaVu Sans,{int(fs * 1.05)},&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,-1,0,0,0,100,100,0,0,1,"
           f"0,0,5,{W // 8},{W // 8},0,1",
           f"Style: Title,DejaVu Sans,{int(fs * 1.6)},&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,-1,0,0,0,100,100,8,0,1,"
           f"0,0,5,0,0,0,1",
           "", "[Events]", "Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text"]
    ass.append(f"Dialogue: 0,{ts(0.3)},{ts(LEAD - 0.1)},Title,,0,0,0,,{{\\fad(500,400)}}THE LAST VIEW")
    for n, c in enumerate(clips, 1):
        for a, b, l in caption_times(c, CAPS[n]):
            ass.append(f"Dialogue: 0,{ts(starts[n-1] + a)},{ts(starts[n-1] + b)},Cap,,0,0,0,,{l}")
    ass.append(f"Dialogue: 0,{ts(starts[7] - 0.2)},{ts(total)},End,,0,0,0,,{{\\fad(600,0)}}If you're watching this"
               f" for the first time…\\N\\N{{\\fad(600,0)}}you've already watched it before.")
    open(f"{WK}/captions.ass", "w").write("\n".join(ass) + "\n")

    # ---- the phone mock-up (img11 on a sideways phone, dark room) ----
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-f", "lavfi", "-i", "color=c=0x0d0d12:s=1600x900",
                    "-i", f"{I}/img11.jpg", "-filter_complex",
                    "[1]scale=1200:675[s];[0]drawbox=x=170:y=92:w=1260:h=716:color=0x1c1c22:t=fill,"
                    "drawbox=x=176:y=98:w=1248:h=704:color=0x2e2e36:t=3,"
                    "drawbox=x=1380:y=420:w=10:h=60:color=0x45454f:t=fill[b];[b][s]overlay=200:112,"
                    "drawbox=x=200:y=772:w=1200:h=6:color=0x444444:t=fill,drawbox=x=200:y=772:w=40:h=6:color=red:t=fill",
                    "-frames:v", "1", f"{WK}/phone.png"], check=True)

    # ---- shots → absolute cut times ----
    shots = []
    for n in range(1, 9):
        for (s, img, fx) in SHOTS[n]:
            shots.append([starts[n-1] + s, img, fx, TRANS.get((img, n), "fade")])
    shots.insert(0, [0.0, "black", "title", "fade"])
    shots = [s for s in shots if s[0] < total]
    cuts = [s[0] for s in shots] + [total]

    inputs, fl, labels = [], [], []
    zw, zh = int(W * 1.25), int(H * 1.25)   # pre-scale for smoother zoompan
    for k, (t0, img, fx, tr) in enumerate(shots):
        a = t0 - (XF / 2 if k else 0)
        b = cuts[k + 1] + (XF / 2 if k + 1 < len(shots) else 0)
        L = b - a; nf = int(round(L * FPS)) + 2
        if img in ("black",) or fx in ("end",):
            inputs += ["-f", "lavfi", "-t", f"{L:.3f}", "-i", f"color=c=black:s={W}x{H}:r={FPS}"]
            fl.append(f"[{k}:v]format=yuv420p,setsar=1[v{k}]")
        else:
            src = f"{WK}/phone.png" if img == "phone" else f"{I}/{img}.jpg"
            inputs += ["-loop", "1", "-framerate", str(FPS), "-t", f"{L:.3f}", "-i", src]
            z = 0.10 / nf
            zexpr = f"1.0+{z:.6f}*on" if fx in ("in", "g") else f"1.10-{z:.6f}*on"
            f = (f"[{k}:v]scale={zw}:{zh}:flags=bicubic,zoompan=z='{zexpr}':x='iw/2-(iw/zoom/2)':"
                 f"y='ih/2-(ih/zoom/2)':d=1:s={W}x{H}:fps={FPS}")
            if fx == "g":
                sh = max(4, W // 120)
                f += (f",rgbashift=rh={sh}:bh=-{sh}:enable='lt(mod(t*7,3.1),0.55)'"
                      f",noise=alls=28:allf=t:enable='lt(mod(t*5,2.3),0.35)'"
                      f",hue=s=1.4:enable='lt(mod(t*3,1.7),0.12)'")
            f += f",trim=duration={L:.3f},format=yuv420p,setsar=1[v{k}]"
            fl.append(f)
    prev = "v0"
    for k in range(1, len(shots)):
        off = cuts[k] - XF / 2
        out = f"x{k}"
        fl.append(f"[{prev}][v{k}]xfade=transition={shots[k][3]}:duration={XF}:offset={off:.3f}[{out}]")
        prev = out
    fl.append(f"[{prev}]ass={WK}/captions.ass:fontsdir=/usr/share/fonts/truetype/dejavu,"
              f"trim=duration={total:.3f}[vout]")

    # ---- narration: clips at their start times, two-pass loudnorm to -16 LUFS ----
    na = len(shots)
    ai = []
    for c in clips: ai += ["-i", c]
    mix = "".join(f"[{na + i}:a]aresample=48000,adelay={int(starts[i] * 1000)}:all=1[a{i}];" for i in range(8))
    mix += "".join(f"[a{i}]" for i in range(8)) + f"amix=inputs=8:normalize=0,apad,atrim=duration={total:.3f}"
    mmix = ("".join(f"[{i}:a]aresample=48000,adelay={int(starts[i] * 1000)}:all=1[a{i}];" for i in range(8))
            + "".join(f"[a{i}]" for i in range(8)) + f"amix=inputs=8:normalize=0,apad,atrim=duration={total:.3f},"
            "loudnorm=I=-16:TP=-1.5:LRA=11:print_format=json")
    meas = subprocess.run(["ffmpeg", "-hide_banner", "-nostats"] + ai + ["-filter_complex", mmix, "-f", "null", "-"],
                          capture_output=True, text=True).stderr
    j = dict(re.findall(r'"(input_i|input_tp|input_lra|input_thresh|target_offset)"\s*:\s*"([-\d.]+)"', meas))
    mix += (f",loudnorm=I=-16:TP=-1.5:LRA=11:measured_I={j['input_i']}:measured_TP={j['input_tp']}:"
            f"measured_LRA={j['input_lra']}:measured_thresh={j['input_thresh']}:offset={j['target_offset']}:"
            f"linear=true,aresample=48000[aout]")
    fl.append(mix)

    out = f"{WK}/test.mp4" if TEST else "media/out/the-last-view-16x9.mp4"
    cmd = (["nice", "-n", "19", "ffmpeg", "-hide_banner", "-y"] + inputs + ai +
           ["-filter_complex", ";\n".join(fl), "-map", "[vout]", "-map", "[aout]",
            "-c:v", "libx264", "-preset", "veryfast" if TEST else "medium", "-crf", "28" if TEST else "19",
            "-pix_fmt", "yuv420p", "-r", str(FPS), "-c:a", "aac", "-b:a", "160k", "-movflags", "+faststart",
            "-t", f"{total:.3f}", out])
    open(f"{WK}/filter.txt", "w").write(";\n".join(fl))
    print(f"shots={len(shots)} total={total:.2f}s starts=" + ",".join(f"{s:.2f}" for s in starts))
    if "--run" in sys.argv:
        subprocess.run(cmd, check=True)
        print("wrote", out)

if __name__ == "__main__":
    main()
