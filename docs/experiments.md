# Experiment register

Rule: each video tests ONE main variable, with the success metric written BEFORE posting. Verdict only from
`docs/metrics.csv` at 7 days. With a few hundred views per video most verdicts will be **inconclusive**: say so.
Changes to skills/prompts/scripts go in a git commit that names the experiment; rollback = `git revert`.
Owner approves every merge, publish and spend.

| ID | Video | Variable changed (vs previous) | Hypothesis | Success metric (set before posting) | Status | Verdict |
|---|---|---|---|---|---|---|
| E1 | Karthika Deepam | Save/share call-to-action in the caption | A "save / share with family" line produces the first saves (baseline 0 saves on both Diwali posts) | Saves > 0 on Instagram at 7 days | planned (post Mon 16 Nov) | |
| E2 | Karthika Deepam | AI narrator (Achird) instead of the owner's voice | Full narration holds viewers longer than the Diwali reels' short voice-over | Instagram avg watch > 4 s (Lakshmi reel) | planned | |

| E6 | Tripurasura Ep 3 (Tue 24 Nov) | A follow ask: end-card line + caption line + pinned comment (one bundled variable; Ep 1 and Ep 2 of the same series have none) | Viewers who finish a series don't know there is more; asking turns a few of them into followers (21 Nov: 99%+ of IG views are non-followers, Tenali 23,846 views gave 2 follows and 2 profile visits) | Instagram follows per 1,000 views at 7 days: Ep 3 at least 2x the average of Ep 1 and Ep 2, and at least 5 follows. Otherwise inconclusive | planned 21 Nov; wording owner APPROVED 21 Nov ("Approve as is") | |

Confounds, stated honestly: Karthika also has a new grade (`rose`), 1080p output and a different story, so E1 and E2
can only be read as hints, not proof. Next video: change one thing only.

**Update 13 Nov (before posting; metrics unchanged):** the video that goes out is **v3**, not the v2 these rows were written for.
v3 also changed the cut (pictures matched to each line, Shiva looking at the viewer), and Instagram gets a voice-only file with
a song added in the app while YouTube has library music baked in. So Karthika differs from the Diwali reels in at least six ways
(story, narrator, grade, resolution, cut, music). E1 and E2 keep their pre-set metrics, but any verdict must be written as
"hint only / inconclusive", and the two platforms must not be compared with each other. E3-E5 (`docs/niche-and-hooks-research.md`)
are the first experiments designed with one variable; register them here when their videos are planned.

**Check 22 Nov (weekly growth check): no verdicts yet.** No experiment's video is 7 days old (Karthika posted 16 Nov: day 6).
E1 and E2 are measured on Instagram, but `docs/posts.csv` has no Instagram post for Karthika (YouTube and Facebook only; the
15-16 Nov lesson says the Instagram one went out from the personal account with a song). Owner to confirm whether it exists and
its link; if it does not, E1/E2 have no reading and stay **inconclusive (not measured)**. E6 needs Instagram 7d readings on
28 Nov, 29 Nov and 1 Dec.

Template for new rows: ID, video, variable, hypothesis, metric + threshold, status, verdict (keep / revert / inconclusive).

## E6 detail (planned 21 Nov 2026): the follow ask
Why: Instagram reach is now large but follows are near zero. 3-day readings (21 Nov), follows per 1,000 IG views:
Tenali 0.08 (2 / 23,846), SM Ep 4 0.52 (3 / 5,770), Lion 0 (0 / 226), SM Ep 3 3.4 (5 / 1,472), SM Ep 2 4.1 (1 / 244). Median 0.52.
Profile visits are tiny too (Tenali: 2), so people are not even tapping the name. Account: 23 followers on 21 Nov.

Control: Tripurasura Ep 1 and Ep 2 (same series, look, narrator and length; no follow ask). Test: Ep 3, the finale.
Changes on Ep 3 only (wording owner APPROVED 21 Nov, "Approve as is"; use exactly):
1. End card: a new line under "UmaAI Studio": `ఫాలో అవ్వండి · మరిన్ని కథలు వస్తున్నాయి`
2. Caption, line before the save line: `👉 ఇలాంటి మరిన్ని కథల కోసం @umaaivideostudio ని ఫాలో అవ్వండి.`
3. Pinned comment, posted by the owner by hand: `భాగం 1, 2 ప్రొఫైల్‌లో ఉన్నాయి 👆 తర్వాతి కథ కోసం ఫాలో అవ్వండి 🙏`
YouTube Short gets 1 and 2 with "సబ్‌స్క్రైబ్ చేయండి" instead of "ఫాలో అవ్వండి" (read separately; not part of the IG verdict).
Confounds: Ep 3 is the finale (finales may draw fans of Ep 1-2) and posts on Karthika Pournami (festival day, bigger reach).
Using a rate (per 1,000 views) handles reach; the finale effect cannot be separated. Expect "inconclusive" unless the gap is large.
If it is a hint: repeat on the next two reels before making it a rule (three references + our own test).
Reading: `metrics.py add` 7d rows for tripurasura-ep1/ep2/ep3 instagram, with follows and profile activity in notes.
