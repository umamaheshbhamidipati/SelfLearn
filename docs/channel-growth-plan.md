# UmaAI Studio: where to post, collabs, and IG/YT/FB in sync (15 Nov 2026)

Owner's goal (15 Nov): make the new Instagram **@umaaivideostudio** a popular channel, add a Facebook page later, keep
YouTube, Instagram and Facebook in sync and watch progress in one place. After 15 Dec 2026 the channel moves into the
owner's SignalIQ project under "business pages" (plan that in a SignalIQ session, not here).

## What went wrong on 15 Nov (measured, web view, ~2 h after posting)
| reel | owner of the post | audio | caption | views | likes |
|---|---|---|---|---|---|
| Ep 1 Samudra Manthan | @umamaheshbhamidipati, collab @umaaivideostudio | original | yes | 1,208 | 27 |
| Karthika Deepam | same | added song (Anoop Shankar, "Chandra Chooda") | none | 72 | 2 |
Both were OWNED by the personal account, so the reach, insights and follow button went there, not to the new channel.
Karthika went up minutes after Ep 1 (same test audience), carried a commercial song and had no caption. Not yet checked
(phone app only): "views from non-followers" in each reel's insights, and Settings -> Account Status on both accounts.

## Rules from now on
1. **Post from @umaaivideostudio** (the post owner). In the composer: Tag people -> **Invite collaborator ->
   @umamaheshbhamidipati**, then accept the invite on the personal account. The reel appears on both grids and in both
   audiences' feeds, but the follow button and the insights belong to the new channel.
2. **One reel a day at most**, at least 6 hours apart. Best slot to test first: 7-9 PM IST (owner's audience after work).
3. **Our own audio only** (narration + YouTube Audio Library / royalty-free music, source noted in `publish.md`).
   No commercial film or devotional songs added in the app.
4. **Caption every post:** Telugu line + English line + 3-5 hashtags (#Telugu #TeluguStories #AIvideo + series tag),
   and the series title prefix (devotional / నీతి కథలు).
5. Reply to every comment in the first hour; pin a comment that points to the next episode.
6. Tick Instagram's AI label and YouTube's "altered or synthetic content" (CLAUDE.md rule).

## Collab invites (who to ask)
- **Always:** @umamaheshbhamidipati (426 followers, Telugu devotional audience) as collaborator on every reel.
- **Telugu devotional / temple pages and Telugu story pages** (100-20K followers, active in the last week): send a
  short DM with the finished reel and offer it as a collab post (both names on it). Owner picks and sends the DMs;
  Claude can draft the message and shortlist pages from a search, but never sends a DM on its own.
- **Family and temple WhatsApp groups, a WhatsApp Channel, Facebook devotional groups** (the Lakshmi reel got 146
  views from FB groups): share the IG link on posting day (roadmap section 3).

## Profile (new channel)
- **Picture:** the same as YouTube (owner, 15 Nov): clay diya in a gold ring on deep navy, no text, reads at 110 px.
  Copy: `media/brand/yt_avatar.jpg` (900x900, gitignored). Use it on Instagram and the future Facebook page too.
- **Name field:** `UmaAI Studio | Telugu AI videos` (the name field is searchable).
- **Bio (draft, owner to check):** the channel is about AI videos in general; series will change (owner, 15 Nov), so
  keep it broad: `AI videos in Telugu 🎬 stories • devotional • more` / `తెలుగులో AI వీడియోలు` / `New reel every week`
  + link to youtube.com/@UmaAIVideoStudio. Series names go in captions and playlists, not in the bio.
- Switch to a **Creator** account (free) for insights; it limits the in-app music library, which is fine (rule 3).

## IG / YT / FB in sync
| step | Instagram | YouTube Shorts | Facebook page (later) |
|---|---|---|---|
| post | from @umaaivideostudio + collab | same file, same day, after IG | link the page in Meta **Accounts Center**, turn on "share reels to Facebook" so each IG reel also posts to the page |
| title | series prefix + Telugu hook | same + `#Shorts` | auto (from IG caption) |
| register | `metrics.py post` with platform `instagram` | platform `youtube` | platform `facebook` |
| readings | 1, 3, 7, 28 days (`metrics.py due`) | same | same |
One video = one row per platform in `docs/posts.csv`; `docs/metrics.csv` then shows all three side by side, and the
Sunday growth check (`docs/growth-check-task.md`) reads them together. Followers per platform go in `docs/growth-log.md`.

## Facebook page: step by step (owner does this on the phone, ~15 min)
Why a Page and not the personal profile: a Page can be linked to @umaaivideostudio, gets its own followers and
insights, and later moves into SignalIQ "business pages" without touching the owner's personal Facebook.
1. **Create the Page.** Facebook app -> Menu (☰) -> Pages -> **+ Create** -> name `Uma AI Studio` (Facebook rejects
   `UmaAI Studio` for its mid-word capitals and suggests `Umaai Studio`; don't take that, 15 Nov), category
   `Video Creator` (add `Digital creator` as a second one). Bio: `AI videos in Telugu 🎬 stories • devotional • more`.
   Skip "invite friends" for now (invite them after there are 3+ reels on the Page).
2. **Same picture.** Profile picture: `yt_avatar.jpg` (the diya; copy it to the phone from Drive or WhatsApp it to
   yourself). Cover photo: optional; a still from Ep 1 cropped to 1640x856 works, or leave it for now.
3. **Username and link.** Page settings -> Username -> `umaaivideostudio` if free (same handle everywhere). Add the
   website `youtube.com/@UmaAIVideoStudio` and the Instagram link in "Edit details".
4. **Link it to Instagram.** Instagram app on @umaaivideostudio -> Settings -> **Accounts Center** -> Accounts ->
   Add accounts -> Facebook -> pick the profile that owns the Page. Then Instagram -> Edit profile -> **Page** ->
   connect `UmaAI Studio`. (Accounts Center links the people; the Page connection links the Page. Both are needed.)
5. **Auto-share reels.** Instagram -> Settings -> Accounts Center -> **Sharing across profiles** -> from
   @umaaivideostudio to `UmaAI Studio` (the Page, not your personal profile) -> turn on **Reels** (and Stories if
   you want). Check on the next reel's share screen that "Share to Facebook" shows the Page name; it remembers the
   choice. Old reels don't copy over: re-share Ep 1 to the Page once by hand from the reel's ⋯ menu.
6. **AI label.** Meta applies the "AI info" label across both apps; still tick it on each reel (rule 6).
7. **First week on the Page:** share the Page link in the same family and temple WhatsApp groups and the FB
   devotional groups that sent 146 views to the Lakshmi reel; post the Page's reel there, not a YouTube link.
8. Register Facebook posts with `metrics.py post` (platform `facebook`) and add Page followers to `docs/growth-log.md`.
Don't: boost posts (paid), buy likes, or post the same reel to 20 groups in an hour (spam flag on a new Page).

## Instagram profile and settings (15 Nov, @umaaivideostudio, web)
- Profile picture set to the diya (`yt_avatar.jpg`) on 15 Nov.
- Found already right: account is **public**; **AI-generated profile** label is on; "show account suggestions on
  profiles" is on (lets others' Similar accounts list show us).
- The Website/link field can only be edited in the phone app (web says so); add youtube.com/@UmaAIVideoStudio there.
- Name field allows 30 characters (the 31-char draft didn't fit). Owner chose and Claude saved (Accounts Center, 15
  Nov): **`UmaAI Studio | Telugu AI Reels`**. Instagram allows two name changes per 14 days.
- Bio saved 15 Nov (owner approved the exact text):
  `AI videos in Telugu 🎬 stories • devotional • more` / `తెలుగులో AI వీడియోలు` / `New reel every week` /
  `▶ YouTube: @UmaAIVideoStudio`.
- Switched **Personal -> Creator** on 15 Nov (owner's yes). Category `Digital creator` (no "Video creator" on web),
  hidden on the profile. Insights now in the Professional dashboard.
- Sharing and reuse: story shares, posts/reels to stories and reposts were already on; nothing changed. Remix is a
  per-reel setting in the phone app. Website embeds left off.
- Still for the owner (phone app): add the link youtube.com/@UmaAIVideoStudio in Edit profile -> Links.
- Page shortlist and collab DM drafts: `docs/collab-shortlist.md`.

## Log
- 15 Nov: plan written. Profile picture: reuse the YouTube diya (no new stills made).
- 15 Nov: FB Page `Uma AI Studio` created by the owner (facebook.com/profile.php?id=61596345551947), Digital
  creator, bio set; Claude set the diya profile picture and the Links (YouTube + Instagram). Username
  `umaaivideostudio` is available but saving it asks for the Facebook password (owner). Page -> Instagram
  connect (Settings -> Linked accounts -> Instagram) did not complete: it needs an Instagram sign-in, and Chrome's
  Instagram session logged out during a Facebook password reset. Still to do (owner): username, Instagram connect,
  then Accounts Center -> Sharing across profiles -> umaaivideostudio -> Uma AI Studio Page -> Reels on.
- 15 Nov (later): FB username set by owner (password step): facebook.com/umaaivideostudio. Saving the Page picture
  created a public "updated their profile picture" post on the Page. Found @umaaivideostudio auto-sharing stories
  and posts to the owner's PERSONAL Facebook profile; owner said turn it off, both toggles now off (verified after
  reload). Page <-> Instagram still NOT connected (web popup never completed): owner to connect in the Instagram
  app (Edit profile -> Page -> Uma AI Studio), then set Share to = the Page and turn Reels on.
- 15 Nov (later): owner connected the Page in the Instagram app; Facebook settings now show "Connected Instagram:
  @umaaivideostudio" on Uma AI Studio. Accounts Center web still lists only the personal profile under "Share to" and
  won't switch it. Set it in the app: Settings -> Accounts Center -> Sharing across profiles -> umaaivideostudio ->
  Share to: Uma AI Studio -> Reels on. Until then, on each reel's share screen turn on "Share to Facebook" and check
  it names the Page.
- 15 Nov (app check): Accounts Center "Share to" offers only personal profiles, never the Page, and the app showed
  "Your Instagram reels" ON to the personal Facebook profile (web hid that switch); owner told to turn it OFF.
  **Reels reach the Page only via the per-reel switch**: on the final share screen turn on "Share to Facebook" /
  "Recommend on Facebook" and check it names Uma AI Studio (owner thinks it shows there; confirm on the next reel).
- 15 Nov: IG profile picture set; collab shortlist + DM drafts in `docs/collab-shortlist.md`; Facebook guide added.
- 16 Nov: Ep 1 and Karthika posted directly to the Uma AI Studio Page (web composer facebook.com/reels/create, as the
  Page): reel/1081439921580559 and reel/2579957275837696. Gotcha: after Post, Facebook may show a "Hosting an event?"
  pop-up (it fired on the Karthika caption); click **Publish Original Post**, not Continue. Leaving the page instead
  silently drops the post (not in Published or Drafts). Turn on "Add AI label" on the second screen (off by default).

## 1 episode -> 5 posts (decided 17 Nov 2026)
Adapted from a "1 video -> 30 posts" multi-agent framework the owner shared. Kept: the Designer (carousels, covers),
the Writer (one caption per platform) and the Analyst (weekly verdict). Dropped: the Clipper (our videos are already
Shorts), the TikTok/X/LinkedIn/Reddit/Threads/Pinterest channels (TikTok is banned in India; little Telugu devotional
audience on the rest) and auto-publishing (no bots on the Google account, Meta's scheduler lacks collab + AI label,
1 reel/day rule).

| # | post | where | cost | notes |
|---|---|---|---|---|
| 1 | Reel / Short | IG (owner @umaaivideostudio + collab) + FB Page + YouTube | done today | as now |
| 2 | Story carousel, 6-8 slides | IG + FB Page | 0 credits | the episode's Nano Banana stills, rose grade, one Telugu line per slide (Noto Serif Telugu), last slide = "full reel on the profile"; aim: saves |
| 3 | Story with a poll | IG story | 0 credits | e.g. "Ep 4: Rahu next?"; links to the reel |
| 4 | WhatsApp message | family / temple groups, later a WhatsApp Channel | 0 credits | 2 Telugu lines + IG/FB link, posting day only |
| 5 | Compilation, 16:9 | YouTube long video | 0 credits, one encode | when a series ends (Samudra Manthan Ep 1-4); helps search |

Also: set a YouTube Shorts cover (thumbnail frame) on every Short; none are set yet.
Weekly Analyst step: add to the Sunday growth check a 3-line verdict ("more of / less of / try next") from
`metrics.py report`, with the sample size stated. No percentage claims from a few hundred views.
First test: the Ep 2 carousel from its existing stills (owner approves the slide text before posting).

## AI disclaimer on the YouTube channel (19 Nov 2026)
Owner approved; added to the UmaAI Studio channel description (Studio -> Customization -> Profile), reloaded and checked
(844 characters). Our own wording, not copied from Om Temple Tales (the reference the owner sent):
"⚠️ AI గమనిక: ఈ ఛానెల్‌లోని దృశ్యాలు, స్వరాలు AI (Google Flow / Veo, Gemini) తో రూపొందించినవి. ఇవి కళాత్మక చిత్రణలు మాత్రమే,
నిజమైన ఫోటోలు గానీ దేవతలు, వ్యక్తులు, ప్రదేశాల యథార్థ చిత్రాలు గానీ కావు. కథలు పురాణాల ఆధారంగా చెప్పబడ్డాయి. అన్ని విశ్వాసాలను,
సంప్రదాయాలను గౌరవిస్తాము. 🙏" + the English version. Facebook Page About: same text, by the owner by hand (Meta automation on hold).
