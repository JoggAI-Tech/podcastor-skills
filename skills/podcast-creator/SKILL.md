---
name: podcast-creator
description: Use when a user wants to create, revise, adapt, or send a Podcast script to Podcastor for voice, avatar, audio, or video production, especially when they provide source material, request a podcast style, or ask to reproduce an abstract script style.
---

# Podcast Creator

Create the script locally in Codex. Use Podcastor only after the user approves the script and explicitly asks to send it there.

## Route The Request

1. For a new episode, ask for the content source first unless it is already supplied. Accept pasted text, an attached file, a URL that can be read, or a topic. Do not claim to have read inaccessible material.
2. Then collect the missing production choices: style, one or two hosts, language, and duration. Defaults are `adaptive`, two hosts, simplified Chinese, and three minutes.
3. Select one style guide and read only that guide before writing:
   - Read [adaptive](references/styles/adaptive.md) for a general episode or when no explicit form is chosen.
   - Read [storytelling](references/styles/storytelling.md) for a narrative, case, history, or character-driven episode.
   - Read [debate](references/styles/debate.md) for a contested question. It requires two hosts.
   - Read [custom style](references/styles/custom-style.md) when the user supplies a reference script or asks to create, refine, or reuse a personal style.
4. For a revision, keep the approved episode context and change only what the user requests. Recheck the output contract after every revision.

## Production Contract

Podcastor currently supports one or two hosts throughout its script, TTS, avatar, and video workflow. Never silently create a three- or four-host script for a Podcastor handoff. Ask the user to choose a one- or two-host adaptation instead.

You may summarize the selected language, host count, and target duration in a sentence before the script. Keep that metadata outside the import-ready script. The import-ready script must contain only this form:

```text
Title: <title>

A: <spoken line>
B: <spoken line>
```

For a solo episode, use only `A`. Every dialogue line must contain spoken language only. Do not add timecodes, stage directions, sound cues, source lists, Markdown fences, speaker names other than `A` and `B`, or commentary inside the script.

Use roughly 250-350 Chinese characters per minute or 120-160 words per minute for alphabetic languages. Treat this as a pacing estimate, not a reason to pad the conversation.

## Revise In Codex

Support natural edits such as shortening the episode, changing the tone, strengthening one host's skepticism, translating it, changing the opening, or replacing a factual claim. Preserve the title, configured language, and allowed speaker labels unless the user requests a change. If a requested rewrite would need unverified facts, qualify the claim or ask for a source.

## Send To Podcastor

Enter this flow only after the user explicitly asks to send the current approved script to Podcastor. Read [the browser workflow](references/podcastor-browser-workflow.md) before using the in-app browser.

The handoff request authorizes populating or uploading the approved script. It does not authorize account creation, credential entry, CAPTCHA completion, avatar creation, credit-consuming audio generation, or video rendering. Ask for confirmation at each of those boundaries.

## Common Mistakes

- Do not use a Podcastor backend script API to generate the script. The bundle generates locally.
- Do not present an unsupported multi-host script as ready for Podcastor.
- Do not send a draft while the user is still revising it, or metadata mixed into the import-ready script.
- Do not create or save a personal style profile until the user expressly approves it.
