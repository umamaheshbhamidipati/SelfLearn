#!/usr/bin/env python3
"""Timeline for the Vaibhav EV reel: shot durations follow the trimmed voice lines.
Writes media/out/seg/durations.txt (key dur), media/out/seg/reel.ass and media/out/seg/voice_filter.txt."""
import json, os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
M = os.path.join(HERE, "media")
VO = os.path.join(M, "audio", "vo")
OUT = os.path.join(M, "out", "seg")
ride = os.path.exists(os.path.join(M, "stills", "s06_ride_a.png"))

def dur(slug):
    p = os.path.join(VO, f"{slug}_trim.wav")
    if not os.path.exists(p):
        return None
    return float(subprocess.check_output(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", p]).decode())

LEAD, TAIL = 0.15, 0.30
# key, voice line, fallback seconds when the line is missing, text style, on-screen text
shots = [
    ("01_dead",   "L1", 3.0, "Hook", r"మీ EV స్కూటర్\Nఆగిపోయిందా?"),
    ("02_phone",  "L2", 3.0, "Hook", r"సర్వీసింగ్ కోసం\Nఎక్కడెక్కడో వెతుకుతున్నారా?"),
    ("03_shop",   "L3", 4.0, "Box",  r"ఇప్పుడు వచ్చేసింది మన\N{\c&H0018E6F5&}వైభవ్ ఎలక్ట్రిక్ మొబిలిటీ!"),
    ("04_batt",   "L4", 3.0, "Box",  r"బ్యాటరీ • చార్జర్ రిపేర్"),
    ("05_motor",  "L5", 2.2, "Box",  r"మోటార్ రిపేర్"),
    ("06_wiring", "L6", 2.6, "Box",  r"కంట్రోలర్ & వైరింగ్ రిపేర్"),
    ("07_brands", "L7", 4.0, "Box",  r"ఏ కంపెనీ స్కూటర్ అయినా\Nసర్వీసింగ్!"),
    ("08_ride" if ride else "08_board", None, 0, "Box", r"నాణ్యమైన స్పేర్ పార్ట్స్\Nతక్కువ ధరలో!"),
    ("09_end",    "L8", 8.0, None, None),   # address + "call now" + the number spoken digit by digit
]

t, rows, events, delays = 0.0, [], [], []
i = 0
while i < len(shots):
    key, slug, fb, style, text = shots[i]
    d = dur(slug)
    if key == "07_brands":            # L7 is long: spread it over 07 and 08
        slot = (d if d else 2 * fb) + LEAD + TAIL
        d07 = round(slot * 0.5, 2)
        nxt = shots[i + 1]
        rows += [(key, d07, style, text), (nxt[0], round(slot - d07, 2), nxt[3], nxt[4])]
        if d: delays.append((slug, t + LEAD))
        t += slot; i += 2; continue
    if key == "09_end":
        sd = max((d or fb) + LEAD + 1.2, 4.0)
    else:
        sd = max((d or fb) + LEAD + TAIL, 2.2)
    sd = round(sd, 2)
    rows.append((key, sd, style, text))
    if d: delays.append((slug, t + LEAD))
    t += sd; i += 1

def ts(x):
    return f"0:{int(x // 60):02d}:{x % 60:05.2f}"

start = 0.0
for key, d, style, text in rows:
    end = start + d
    if key in ("01_dead", "02_phone", "08_ride"):
        events.append(f"Dialogue: 0,{ts(start)},{ts(end)},AI,,0,0,0,,AI-generated image")
    if style:
        events.append(f"Dialogue: 0,{ts(start)},{ts(end)},{style},,0,0,0,,{{\\fad(120,120)}}{text}")
    if key == "09_end":
        for s, txt in (("Name", r"VAIBHAV\NELECTRIC MOBILITY"),
                       ("Info", r"EV సర్వీస్ & సేల్స్\Nనాయుడుపేట సర్కిల్, కలవొడ్డు రోడ్, ఖమ్మం"),
                       ("Phone", "కాల్: 74166 09872")):
            events.append(f"Dialogue: 0,{ts(start)},{ts(end)},{s},,0,0,0,,{{\\fad(200,0)}}{txt}")
    start = end

os.makedirs(OUT, exist_ok=True)
with open(os.path.join(OUT, "durations.txt"), "w") as f:
    for key, d, *_ in rows:
        f.write(f"{key} {d}\n")
head = open(os.path.join(HERE, "reel.ass"), encoding="utf-8").read().split("[Events]")[0]
with open(os.path.join(OUT, "reel.ass"), "w", encoding="utf-8") as f:
    f.write(head + "[Events]\nFormat: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text\n" + "\n".join(events) + "\n")
with open(os.path.join(OUT, "voice.json"), "w") as f:
    json.dump({"total": round(start, 2), "lines": [[s, round(x, 3)] for s, x in delays]}, f)
print(f"total {start:.2f} s; voice lines {len(delays)}; missing: {[s[1] for s in shots if s[1] and dur(s[1]) is None]}")
