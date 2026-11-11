# Experiment register

Rule: each video tests ONE main variable, with the success metric written BEFORE posting. Verdict only from
`docs/metrics.csv` at 7 days. With a few hundred views per video most verdicts will be **inconclusive**: say so.
Changes to skills/prompts/scripts go in a git commit that names the experiment; rollback = `git revert`.
Owner approves every merge, publish and spend.

| ID | Video | Variable changed (vs previous) | Hypothesis | Success metric (set before posting) | Status | Verdict |
|---|---|---|---|---|---|---|
| E1 | Karthika Deepam | Save/share call-to-action in the caption | A "save / share with family" line produces the first saves (baseline 0 saves on both Diwali posts) | Saves > 0 on Instagram at 7 days | planned (post Mon 16 Nov) | |
| E2 | Karthika Deepam | AI narrator (Achird) instead of the owner's voice | Full narration holds viewers longer than the Diwali reels' short voice-over | Instagram avg watch > 4 s (Lakshmi reel) | planned | |

Confounds, stated honestly: Karthika also has a new grade (`rose`), 1080p output and a different story, so E1 and E2
can only be read as hints, not proof. Next video: change one thing only.

Template for new rows: ID, video, variable, hypothesis, metric + threshold, status, verdict (keep / revert / inconclusive).
