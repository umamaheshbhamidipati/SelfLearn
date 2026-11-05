# Browser gotchas (Claude in Chrome)

## Uploading files into Flow (transient file input)
Flow creates its `<input type=file>` only when you click **+ → Upload**, then opens a native picker Claude can't use.
Hook the click so the input stays in the page, then use `file_upload` on it:

```js
// 1. run before clicking + → Upload
window.__fileInput = null;
window.__origClick = HTMLInputElement.prototype.click;
HTMLInputElement.prototype.click = function () {
  if (this.type === 'file') {
    window.__fileInput = this; this.value = '';
    this.setAttribute('aria-label', 'UPLOADTARGET');
    this.style.cssText = 'display:block;position:fixed;top:300px;left:500px;width:200px;height:40px;opacity:1;z-index:99999';
    if (!this.isConnected) document.body.appendChild(this);
    return;
  }
  return window.__origClick.call(this);
};
```
2. Click **+** then **Upload**. If `find` can't see it: `document.body.appendChild(window.__fileInput)`.
3. `find "UPLOADTARGET file input"` → `file_upload` with the path(s).
4. Restore: `window.__fileInput.style.cssText='display:none'; HTMLInputElement.prototype.click = window.__origClick;`

Pitfalls: Flow reuses the same input element, so always reset `window.__fileInput = null` before each upload or
you'll re-send the old file. The header shifts when a "PLUS" badge appears — re-screenshot before clicking.

## Adobe Firefly
File inputs live in shadow DOM. Walk shadow roots, move the input to `document.body`, then `file_upload`.

## Upload limits
`file_upload` accepts ≤ 10 MB per call and only files the session can read. Copy source files into the
session scratchpad first if the folder isn't shared. A 30 s 720p cut is ~14 MB — too big; post from the phone.

## Downloads
- Chrome may save straight to the folder the user last used, or park the file as `Downloads\<guid>.tmp` behind a
  Save dialog. The `.tmp` is complete — check the header (`ftyp` = mp4, `\x89PNG` = png) and copy/rename it.
- Find fresh downloads: `find <dirs> -maxdepth 1 -newermt "-3 minutes" -type f`.
- Kling / Firefly in-page video sources are MediaSource blobs — you can't fetch them. Use the site's Download button.

## Popups to expect
Pricing upsells (close), occupation surveys (close — never fill personal data), privacy-policy screens
(ask the user first), "Always approve" credit spending (never pick it).

## Free tiers seen (Oct 2026, India)
| Tool | Free | Cost per 5 s clip |
|---|---|---|
| Google Flow | 50 credits/day | Veo 3.1 Lite 10 credits (8 s, 720p, has audio) |
| Gemini app video | paywalled (AI Plus) | — |
| Kling | 66 trial credits; one job at a time, 2–5 min queue | 2.1 720p = 20 credits; watermark |
| Adobe Firefly | 250 credits/month | Firefly Video 540p = 100 credits |
Flow was the clear winner on quality and cost. Visible watermark is mandatory in India on Flow.
