# Flow (Veo) prompt template

Write each shot as one paragraph in this order. Keep the **Character** and **Style** blocks
identical, word for word, in every shot of a video: that is what keeps it consistent.

```
[Shot type + camera]   e.g. Medium close-up, slow dolly-in, eye level, 35mm lens.
[Subject + action]     Who/what, doing exactly one clear thing in this shot.
[Character block]      Fixed description: age, face, hair, clothing, colours. (Same every shot.)
[Setting]              Place, time of day, weather, key props.
[Lighting + mood]      e.g. warm golden-hour backlight, soft haze, calm.
[Style block]          e.g. photorealistic, shallow depth of field, natural colour grade. (Same every shot.)
[Audio]                Ambient sound / one short line of dialogue in quotes / "no music".
[Avoid]                text on screen, logos, extra people, distorted hands.
```

Tips
- One action per shot; 8-second clips work best. Cut long actions into several shots.
- Use a Nano Banana reference image of the character as "ingredient" when Flow offers it.
- Change one thing at a time when a shot fails, and note it in `log.md`.
- Good prompts go into `docs/prompt-library.md`.
