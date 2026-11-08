# Telugu AI voice samples (2026-11-08)

Model `gemini-3.8-flash-tts` via the Gemini API (key in `.env`, free tier: Google may use inputs/outputs
and human reviewers may read them; never put personal info in scripts). Same text for every voice
(`sample.txt`), style prompt: "warm, gentle devotional storyteller, calm and reverent, unhurried".
Output: 24 kHz mono WAV in `inlineData` (RIFF header) → loudnorm −16 LUFS → mp3 in `media/` (gitignored).
~10 s per request.

| Voice | Length | Owner's verdict |
|---|---|---|
| Sulafat | 23.1 s | |
| Vindemiatrix | 26.0 s | |
| Achird | 24.8 s | |
| Charon (male) | 27.1 s | |

Pace: ~35 Telugu words took 23–27 s, slower than planned. A 25–30 s Reel fits ~35–40 words at this
style, not 60–75; ask for a slightly faster pace if more words are needed.
