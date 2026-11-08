# Plan — AI voice + language by region (drafted 2026-11-08)

**Goal:** narrate each Reel with an AI voice in Telugu, and let viewers hear it in *their* language
(Hindi, Tamil, Kannada, English…) without making separate videos by hand.

**Principle:** one Telugu master video → the platforms do the per-viewer language switch where
they can; we fill the gaps. Telugu stays the channel's identity.

## How each platform switches language

| Platform | Mechanism | Who picks the language | Status for us |
|---|---|---|---|
| Instagram | **Meta AI translations**: dubs the Reel's voice (optional lip-sync), label "Translated with Meta AI" | Viewer's app language, automatic | Free for public accounts; Telugu, Hindi, Tamil, Kannada, Bengali, Marathi, English (Jan 2026). **Verify the toggle appears in the owner's app** |
| YouTube | **Multi-language audio**: we upload extra audio tracks to the same video | Viewer's YouTube language, automatic; switchable in the player | Gradual rollout, needs "Advanced features"; **Shorts support unclear**. Verify in Studio |
| YouTube (fallback) | Auto-dubbing by YouTube | Automatic | Not offered to every channel; check Studio |
| YouTube (fallback 2) | Separate Short per language, same title prefix + language tag | Algorithm by viewer interest | Always works; costs extra uploads, splits views |

Platform translation works only on **speech**. Music-only Reels have nothing to translate, so every
Reel in this series needs narration from start to end.

## Phase 0 — checks (one session, ~30 min, 0 credits)

1. **YouTube Studio → Settings → Channel → Feature eligibility**: is "Advanced features" on for
   UmaAI Studio? If not, it needs phone verification (owner does it) or channel history.
2. **YouTube Studio → upload an existing Short → Languages/Subtitles**: is "Add audio track"
   offered for a Short? Record yes/no here.
3. **Instagram app (owner, on phone)**: when posting a Reel, look for "Translate with Meta AI"
   under advanced settings. Record which languages it lists.
4. **Voice tool test** in Google AI Studio (Gemini TTS, via Claude in Chrome): 3 Telugu sample
   lines in 3–4 different voices. Owner picks one voice by ear (Claude cannot judge audio).
   Then the same lines in Hindi and English with that voice.
5. **Licence check**: read the current Gemini API / AI Studio terms on using generated audio in
   videos (incl. monetised). Record the answer and the date here. Until it is clear: fine for an
   unmonetised channel; re-check before applying for monetisation.

| Check | Result | Date |
|---|---|---|
| YT Advanced features | | |
| YT audio tracks on Shorts | | |
| IG Meta AI translate toggle + languages | | |
| Chosen AI voice (name) | | |
| Gemini TTS terms on video use | | |

## Phase 1 — pilot Reel (one video, ~150–200 Flow credits)

- **Topic idea:** Karthika masam / Karthika deepam: why Telugu homes light lamps all month
  (starts right after Diwali; very Telugu, follows on from the Diwali series). Confirm dates first.
- **Script:** 25–30 s of narration, about 60–75 Telugu words, short sentences (translation and
  lip-sync handle short lines better). One idea per line, hook question in line 1.
- **Voice:** generate the Telugu narration in AI Studio → `media/audio/vo-te.wav`. Pace the cut to
  the voice (voice first, then cut the clips to it), music under it at 10–20 %.
- **Visuals:** the usual pipeline (stills → Flow clips → cut → grade). Keep mouths mostly off
  screen or in wide shots, so dubbing doesn't look out of sync (lip-sync is optional on IG).
- **Captions:** burned Telugu captions only on the YouTube Telugu version; Instagram version
  without burned captions, so a dubbed viewer doesn't see mismatched Telugu text.
- **Extra languages (YouTube only, if audio tracks work):** Hindi + English narration from the same
  voice, each mixed with the same music → `vo-hi`, `vo-en` tracks. Claude checks the translation
  makes sense; the owner checks Hindi by ear.
- **Disclosure:** AI label on both platforms (AI voice + AI visuals); note "AI voice" in the
  description.

## Phase 2 — compare and decide (7 days after the pilot)

Compare in `docs/growth-log.md`:

| Version | Avg watch time | Shares/saves | Views from non-Telugu regions |
|---|---|---|---|
| Diwali Instagram (owner's own voice, end only) | | | |
| Diwali YouTube (music only) | | | |
| Pilot Instagram (AI Telugu voice + Meta translation) | | | |
| Pilot YouTube (AI voice + extra tracks, if any) | | | |

Decide: AI voice vs owner's voice for the series; whether translation brings real viewers (Insights
→ audience by country/language); keep or drop extra YouTube tracks.

## Repo changes (only when Phase 1 starts)

- `scripts/add-audio.sh`: support a voice + music mix with music ducked under the voice.
- A helper to mux extra language tracks for upload, if YouTube supports them.
- `templates/publish.md`: voice/translation checklist (done, see "Voice and languages").
- No API key for now: generate voices in the AI Studio web UI. If we later use the Gemini API,
  the key goes in `.env` (chmod 600, gitignored).

## Risks

- Translation quality: Meta AI may mistranslate devotional terms (names of gods, rituals). Review
  each translation before it goes live (Instagram allows this).
- AI Telugu voice may sound flat for devotional content; the owner's real voice may perform better.
  Phase 2 decides with data, not taste.
- Platform features change fast; re-check Phase 0 results monthly.
