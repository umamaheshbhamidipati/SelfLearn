# Niche and hooks for the Indian audience: research (12 Nov 2026)

**Evidence quality warning.** Almost all public sources are marketing blogs, vendor pages or company-commissioned surveys. No source gave Telugu-specific
or devotional-specific numbers for Reels/Shorts. Treat everything below as **hypotheses to test with our own metrics** (`docs/metrics.csv`, `experiments.md`).

## What we know from our own data (8 Nov)
- YouTube Short (Diwali Lakshmi): 256 views, 0:25 average view, **75.8 % swiped away**, +4 subscribers.
- Instagram Reel (same video): 353 views, **0:04** average watch (baseline 0:02), 1 share, 0 saves, 65 % non-followers.
- Revenue 0; costs not logged yet.

## Market signals (sources in brackets; all secondary)
- Short video is huge in India: about 680 M monthly users across Reels, Shorts and Moj ([Storyboard18](https://www.storyboard18.com/digital/micro-dramas-replace-reels-and-shorts-as-95-of-viewing-shifts-away-from-short-form-video-redseer-85881.htm), [Campaign India](https://www.campaignindia.in/article/indias-video-split-short-clips-surge-long-form-holds-ground/43n5wpfg2myzv5fjjxrg7zyw46)). Meta's own study (Ipsos, June 2026): 89 % of Gen Z and 85 % of women use Reels daily, rural almost as much as urban ([Meta](https://about.fb.com/news/2026/06/reels-is-shaping-indias-video-first-future-across-gen-z-women-bharat/)). Company-sourced.
- **Serialised vertical stories (micro-dramas, AI-made story shorts) are the fast-growing format** ([ThePrint](https://theprint.in/brandit/ai-generated-micro-dramas-and-story-based-shorts-are-rapidly-expanding-across-social-platform/2945103/), [Hollywood Reporter India](https://www.hollywoodreporterindia.com/features/insight/indias-microdrama-boom-how-data-desire-and-aritifical-intelligence-are-reshaping-entertainment)). Our Samudra Manthan 3-episode series fits this.
- Devotional is a proven evergreen: [Forbes India](https://www.forbesindia.com/life/entertainment/the-evergreen-evolving-industry-of-devotional-music-article/3000229) (Hanuman Chalisa video passed 5 B views; regional-language devotional stays important). Festival-driven spikes (Shravan, Navratri, Kartik) are described anecdotally only.
- Mythology made with AI is crowded and monetisation paths are unclear ([Entrepreneur / Mint pieces](https://www.magzter.com/en/stories/business/Entrepreneur-magazine/AI-USHERS-IN-A-NEW-ERA-FOR-MYTHOLOGICAL-STORYTELLING)); AI history channels can reach 64 K+ subscribers and be monetised ([BOOM](https://www.boomlive.in/amp/decode/ai-history-videos-india-reels-youtube-viral-29514)).
- Telugu is one of the largest Indian-language audiences with less competition than English or Hindi (weak sources); income claims (e.g. ₹40-80 RPM) are unsourced anecdotes.
- **YouTube July 2026 clarification of "inauthentic content":** mass-produced, repetitive or low-effort videos can lose monetisation; AI use is allowed if the videos add unique value ([Metricool](https://metricool.com/youtube-ai-content-rules-monetization/), [eWeek](https://www.eweek.com/news/youtube-responds-to-ai-concerns/)). Threshold not defined; reviews look at the whole channel. This favours **sourced, original, varied, episodic** work over a stream of near-identical clips.

## Niche: what to do
1. **Stay in Telugu devotional / mythology, but go for "sourced story series" not "pretty clips".** Our edge: scripts checked against sources (`research.md`), consistent characters, proper Telugu narration, belief-based moments labelled as belief. That is also the safest answer to the inauthentic-content rule.
2. **Series over one-offs.** Samudra Manthan Ep 1-3, then a joined vertical video; each episode ends on a cliffhanger line. Keep playlists and a fixed title prefix.
3. **Festival calendar.** Plan 2-4 weeks ahead for the big Telugu festival moments (verify dates before planning: Sankranti, Maha Shivaratri, Ugadi, etc.). One festival video ready before each, not rushed after.
4. **Two content types:** (a) story episodes (slow, researched), (b) 15-20 s "devotional micro-explainers" (why we light the lamp, why this day) in the Karthika style: cheap in credits, high reuse.
5. **Don't chase** AI "real people" personas, copyrighted characters or music, or mass-produced variants of the same clip.

## Hooks: what to do (evidence is mostly blogs; test each)
Consistent advice across sources: decide within ~1.5-2.5 s; open on motion or a specific question, not a logo or greeting; a face or person early helps; speech-led openings beat music-only; on-screen text helps music-led videos; a pattern interrupt about every 4 s holds viewers better than static shots ([DEV hook summary](https://dev.to/bulkdl/hook-engineering-the-science-of-the-first-3-seconds-in-short-form-video-2026-2jp9), [Emplifi](https://emplifi.io/?p=23678)). No official platform figure exists for 3-second retention; numbers like "70 % at 3 s" are vendor claims.

Our hook formulas for Telugu devotional:
| Formula | Example (Telugu line idea) | Use for |
|---|---|---|
| Question that the viewer has asked at home | "కార్తీక మాసంలో దీపం ఎందుకు వెలిగిస్తాం?" (used on Karthika) | micro-explainers |
| Impossible-sounding event at second 0 | "అమృతం కోసం మథిస్తే… ముందు పుట్టింది విషం!" (Ep 2) | story episodes |
| Image of awe + one-line promise | Kurma lifting the mountain, voice: "ఈ పర్వతాన్ని మోసింది ఒక తాబేలు" | Ep 1, hero shots |
| Cliffhanger carried from last episode | "తర్వాత: నీలకంఠుడు" | series continuity |
| Save/share reason at the end | puja day and time, mantra line, "Save for Friday" | every video |
Rules: first frame is the strongest image (not a slow reveal); motion in the first second; Telugu captions burned in from 0:00; the first spoken line is the hook; keep cuts at 1.5-3 s.

## Experiments to run (one variable each; pre-set the metric; 7-day verdict)
- **E3 hook type:** question hook vs impossible-event hook on two similar micro-explainers. Metric: YouTube "stayed to watch" (baseline 24.2 %) and Instagram average watch time (baseline 0:04).
- **E4 save prompt:** end card with puja day/time vs none. Metric: saves (baseline 0).
- **E5 series cliffhanger:** does Ep 2's first-day views beat Ep 1's after an Ep 1 cliffhanger? Metric: Ep 2 views at 24 h vs Ep 1 at 24 h, and followers gained per episode.
Log rows in `docs/metrics.csv` at 24 h, 3 d, 7 d; one lesson per experiment in `docs/lessons.md`.

## Gaps to close next (cheap)
- Telugu-specific devotional channel stats (open YouTube Studio's "Research" tab and look at what Telugu devotional Shorts get; owner's own signed-in view is better than blogs).
- Verify the 2027 festival dates and write the calendar.
- Check YouTube's official AI-disclosure help page text (the search results did not quote it).
