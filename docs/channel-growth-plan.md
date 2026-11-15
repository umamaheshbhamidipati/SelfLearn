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
1. **Create the Page.** Facebook app -> Menu (☰) -> Pages -> **+ Create** -> name `UmaAI Studio`, category
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
- 15 Nov: IG profile picture set; collab shortlist + DM drafts in `docs/collab-shortlist.md`; Facebook guide added.
