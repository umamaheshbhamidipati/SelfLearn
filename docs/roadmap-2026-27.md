# Money audit and 1-year roadmap (15 Nov 2026 to 14 Nov 2027)

Written 15 Nov 2026 by a second Claude session (Fable 5.2) at the owner's request, from the repo's own
logs plus two web searches. Not checked: YouTube Studio, Instagram insights. Figures marked *estimate*
are judgement, not data. Platform rules below come from secondary sources: confirm each on YouTube's
own Help pages before acting on it.

## 1. Will this make money? Short answer

**Not from Shorts ads within a year, on the current path.** It can make some money from long videos
and from selling the skill. Treat the channel as paid learning for 12 months, with a small services
income as the realistic first rupee.

### Where we are (repo data, 8 Nov, plus the owner on 14 Nov)
| | YouTube UmaAI Studio | Instagram |
|---|---|---|
| Audience | ~10 subscribers, all people the owner knows | 426 followers |
| Views per post | 250-300 | 300-350 |
| Retention | 0:25 average, but 75.8% swipe away at the start | 0:04 average watch |
| Shares / saves | n/a | 1 / 0 |
| Revenue | 0 | 0 |
| Logged cost | Flow PLUS 399/month (Claude plan not logged) | |

### The gap to ad revenue
- Ads tier (reported): 1,000 subscribers **and** 10 million Shorts views in 90 days, or 4,000 watch
  hours of long videos in 12 months.
- 10 million in 90 days is about 111,000 views a day. We get about 600 a week. That is roughly a
  1,000-fold gap.
- One source reports that from 1 Feb 2027 new channels need 8,000 hours or 20 million Shorts views.
  Unconfirmed. We cannot reach either bar by then, so do not rush for it.
- Even at 10 million Shorts views a quarter, Indian Shorts pay roughly 2-10 rupees per 1,000 views
  (blog ranges, no devotional or Telugu data): about 7,000-33,000 rupees a month. Shorts ads are a
  small prize even when they work.
- Instagram pays Indian creators nothing per view, as far as we know. Money there is brand deals,
  which need a far larger following.

### Where money can realistically come from (ranked, *estimate*)
1. **Services.** Custom AI festival greetings, temple event videos, shop and wedding-invite clips for
   people and businesses the owner already knows. Needs no subscribers. This is the fastest route.
2. **Long videos (6-12 minutes).** Full stories and "5 moral stories" compilations build watch hours
   and pay several times more per view than Shorts. Every Short should also be a piece of a long video.
3. **The how-to channel.** @UmaMaheshBhamidipati already has 332 subscribers and a 139K-view how-to.
   "How I make AI devotional videos in Telugu" fits that audience, and tutorials attract better ads.
4. **Shorts ads, memberships, Super Thanks.** Only after the thresholds; treat as a bonus.

### Risks that can cost the money later
- **Reused clips.** The 0-credit micro-explainers reuse Episode clips. YouTube's inauthentic and
  reused-content rules look at the whole channel. Every video needs its own narration, its own hook
  and at least one new picture; never post near-copies.
- **"Made for kids."** Moral stories marked as made for kids lose personalised ads, comments and
  notifications. Write for a family audience and decide the setting per video with that cost in mind.
- **Bought or swapped subscribers.** Sub4sub, paid subscribers and engagement groups break YouTube's
  fake-engagement policy and teach the feed that our viewers do not watch. Never do this. The honest
  "volume push" is distribution (section 3).
- **Hardware.** The planned Ryzen + 3090 PC cannot be paid back by this channel in a year. Buy it for
  learning, not as a channel investment.
- **CapCut through a VPN** stays the owner's decision; nothing in the pipeline should depend on it.

## 2. What the owner should give Claude so it can learn by itself

The best teacher is our own data, then other people's proven videos.

1. **Our analytics, weekly.** YouTube Studio: the retention graph screenshot and the "stayed to
   watch" figure for every Short. Instagram: insights for every Reel. Without these, lessons are guesses.
   `metrics.csv` has had no row since 8 Nov: Happy Diwali has no 3-day or 7-day row and Lakshmi no
   7-day row. (Karthika and Ep 1 only go out on 16 Nov.) Use the `analytics-ingest` skill.
2. **Reference videos, 15-20 links.** Telugu devotional and moral-story Shorts from channels that are
   clearly growing, picked by the owner from the YouTube Studio Research tab and the Shorts feed.
   For each: link, why the owner likes it, views. Add 5 that the owner disliked. Claude then writes
   a beat-by-beat teardown (hook line, first frame, cut rhythm, caption style, ending) into
   `docs/reference-reels.md` and turns repeated patterns into checklist lines.
3. **Three long videos** (6-12 minutes) of Telugu stories that held the owner's attention, for the
   long-form structure.
4. **Viewer comments and WhatsApp reactions**, pasted as text. These show what people actually felt.
5. **Official rule pages**, saved as text in `docs/policy/`: YouTube channel monetisation policies,
   the altered or synthetic content disclosure page, the Shorts monetisation page, Instagram's branded
   content rules. Claude should quote these, not blogs.
6. **Story sources.** The Telugu Purana and Panchatantra editions the owner trusts, so facts are
   checked against one named source.

### Skills worth adding (build them here, from tested steps, one at a time)
| Skill | What it does | Why |
|---|---|---|
| reference-teardown | Contact sheet + transcript of a reference Short into a beat sheet | Learn from proven videos in a repeatable way |
| analytics-ingest (**built 15 Nov**) | Screenshots or typed figures into `metrics.csv`, a due list, a report against the targets | Measurement keeps falling behind |
| fact-check | Script lines checked against the named source, belief marked as belief | Protects trust and the "original value" case |
| long-form-build | Joins episodes into a 16:9 or 9:16 long video with chapters and a cover | Opens the watch-hours route |
| publish-pack | Title, description, tags, cover, pinned comment, playlist, disclosure tick list | Removes the slowest manual step |

Two skill zips sit in `~/Downloads` (`Social Media Skills-1.0.1-v1.zip`, `capcut-skill.zip`). They
are downloads from the internet: read every file in them before installing, and install nothing that
runs scripts, asks for sign-ins or sends data out.

## 3. Operating rules (how a professional creator would run this)
- **One job per video:** stop the swipe in second 1, give one fact or feeling, give a reason to save.
- **Series, not singles.** Fixed title prefix, cover style and playlist per series. Pinned comment
  and related-video link to the next episode.
- **Batch.** Festival videos are finished two weeks before the day. Verify every 2027 festival date
  in a panchangam before planning; none are verified in this file.
- **One variable per video**, metric written before posting (`docs/experiments.md`).
- **Distribution is the honest volume push:** family and temple WhatsApp groups and Status, a WhatsApp
  Channel, Facebook devotional groups (the Lakshmi reel already got 146 views there), Instagram Collab
  posts with Telugu devotional pages, replies to every comment in the first hour.
- **20-minute weekly review** on Sunday: numbers in, one lesson out, one decision.
- **Session hygiene for Claude:** one session per video, start fresh when context passes about half.
  The 14-15 Nov session reached 90% context and burnt the usage limit mid-build.

## 4. Roadmap with gates

### Quarter 1, 15 Nov to 14 Feb: rhythm and retention
- Output: 3 posts a week (Mon episode, Tue or Thu micro-explainer, Sat moral story). About 36 posts.
- Finish Samudra Manthan Ep 1-3, then join them into the first long video.
- Sankranti video ready by 31 Dec.
- Targets: "stayed to watch" from 24% to 40%; Instagram average watch from 4 s to 8 s; saves above 0;
  100 subscribers who are strangers.
- **Gate, 14 Feb:** after 30 posts, if the median Short is under 1,000 views and "stayed to watch" is
  under 35%, change the format (hook, voice, length, niche). Do not answer weak numbers with more volume.

### Quarter 2, 15 Feb to 14 May: find the winner, start long videos and services
- Keep the best series by retention, stop the weakest.
- Two long videos a month (one devotional story, one moral-story compilation).
- Festivals: Maha Shivaratri, Ugadi, Sri Rama Navami.
- One "how I make it" tutorial a month on the personal channel.
- Services test: make 3 paid custom videos for people the owner knows. Log price and hours in `finance.csv`.
- Targets: 500 subscribers; 200 watch hours; first rupee earned.
- **Gate, 14 May:** if no series has beaten the channel median by 3 times, test a second language
  (Hindi dub of the top 5) or a different niche in Quarter 3 instead of more of the same.

### Quarter 3, 15 May to 14 Aug: monetisation attempts
- Productise the service: fixed packages, sample reel, a simple order form.
- Dub the top 10 videos into one more language as a one-variable test (`docs/multilingual-voice-plan.md`).
- Festivals: Varalakshmi Vratam, Krishnashtami, Vinayaka Chavithi (prepared in this quarter).
- Apply for the early YouTube tier if the thresholds are met and it is offered in India.
- Targets: 1,000 subscribers; 1,000 watch hours; services income covers all tool costs.

### Quarter 4, 15 Aug to 14 Nov: scale what pays
- Dasara, Diwali and Karthika season: all videos finished 2-4 weeks early, using the year's lessons.
- Put time only into the income lines that paid in Quarter 3.
- **Year-end decision, 14 Nov 2027:** continue as a business, continue as a hobby, or move the skill
  fully into services and tutorials.

### Honest year-end range (*estimate*)
| | Low | Likely | High |
|---|---|---|---|
| YouTube subscribers | 200 | 1,000-3,000 | 10,000+ (needs one series to break out) |
| Instagram followers | 600 | 1,500-3,000 | 10,000+ |
| Ad income for the year | 0 | 0 to a few thousand rupees | tens of thousands |
| Services income for the year | 0 | 20,000-60,000 rupees | 1.5 lakh+ |

Tool cost for the year: Flow 4,788 rupees plus the Claude plan (not logged yet; add it to `finance.csv`).

## Sources (secondary; confirm on YouTube Help)
- Partner Programme thresholds: https://vidiq.com/blog/post/monetize-youtube-guide/ ,
  https://air.io/en/monetization/youtube-partner-program-requirements-2026-the-complete-guide
- Reported February 2027 change: https://ppc.land/new-youtube-creators-face-8-000-hour-bar-for-ad-revenue-from-february-2027/
- Indian Shorts pay per 1,000 views: https://bosswallah.com/blog/creator-hub/youtube-shorts-monetisation-in-india-2026-real-numbers-real-payout-timelines/ ,
  https://www.wscubetech.com/blog/youtube-income-per-1000-views/
