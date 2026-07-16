---
name: podcast-creator
description: Use when a user wants a locally generated Podcast script or a Podcastor episode with selected hosts, voices, avatars, audio, or video, including topic discovery, style adaptation, revisions, and Studio setup.
---

# Podcast Creator

Generate and revise the script locally in Codex. Use Podcastor only as the visual, voice, audio, and video production surface. Never call a Podcastor backend script generator.

## Required Interactions

Keep interaction to one combined topic-and-style confirmation and one browser-handoff confirmation. Do not show separate host-count questions, duration questions, `continue_studio` questions, or `studio_form`/`voice_selection` questions. Infer ordinary defaults and make the decision visible in the result:

- topic/source: use the supplied text, file, URL, or topic; for an explicit request for current or hot news, research accessible reporting and select the strongest angle automatically;
- topic research: perform the mandatory Deep Research (DeepReach) workflow for both discovered candidates and user-supplied topics before making a proposal;
- style: choose the route below from the topic and source;
- presentation: recommend a Podcastor form from `Solo`, `Talk Show`, `Split Screen`, `Two-Shot`, `Cartoon`, `Pet`, or `Visual` using the production matrix in the browser workflow;
- hosts: use the requested count, otherwise two; `debate` always uses two;
- language: use the requested language, otherwise simplified Chinese;
- duration: use the requested duration; for Podcastor, map it to the nearest supported band in [duration bands](references/duration-bands.md), otherwise default to `~5min`.

If a source is inaccessible, say so and do not invent details. When a request has no concrete topic or source, ask only for the minimum missing topic information. For every viable topic, state the proposed topic/title and angle, recommend one script style and one Podcastor presentation form with short reasons, and optionally name one presentation alternative. Require the user to confirm or adjust that combined proposal before drafting. When topic discovery produces multiple viable candidates, present two or three grounded candidates with a recommended script style and presentation form for each and require the user to select one. A supplied topic or source starts a proposal; it is topic-and-style confirmation only when the user explicitly confirms it and accepts the recommendation. A user-requested local-only script never opens Podcastor.

For required content or handoff choices, use the native `request_user_input` tool when exposed; otherwise use one concise normal-language question. Batch independent topic fields such as source, audience, and intended outcome into at most three questions. Do not request passwords, OTPs, CAPTCHA answers, payment details, tokens, cookies, or credentials.

After displaying a production-ready non-local script, obtain one explicit browser-handoff confirmation before opening Podcastor. State that confirming authorizes Studio entry, automatic form/host/voice recommendations, audio rendering, video rendering, and video download for that exact script. Do not ask again for those actions. Login, registration, verification, and CAPTCHA remain user-completed boundaries; pause there and ask the user to finish in the site.

## Mandatory Topic Deep Research

Before presenting any topic proposal, read and execute [topic deep research](references/topic-deep-research.md). Apply it to both discovered candidates and a topic supplied or selected by the user; user selection confirms editorial interest, not factual readiness. For online research, use Firecrawl search and scrape results into `.firecrawl/topic-research/`. Do not send private attachments, local file contents, credentials, or personal data to a web research provider. If available evidence is insufficient, say so, lower the score, and propose a narrower or better-supported angle rather than inventing facts.

## Topic And Style Routing

After Deep Research, present a scored topic plan: title, audience, editorial question, strongest angle, key content pillars, evidence gaps, script route, duration band, spoken-body target, and Podcastor presentation form. Give one concise reason for the script route and the presentation form. Read only the matching guide after the user confirms the topic-and-style proposal, then draft:

- `adaptive`: explanation, analysis, news commentary, product, or general discussion. Read [adaptive](references/styles/adaptive.md).
- `storytelling`: case, history, character, sequence of events, or narrative reveal. Read [storytelling](references/styles/storytelling.md).
- `debate`: a genuinely contestable question with two credible positions. It requires exactly two hosts. Read [debate](references/styles/debate.md).
- `custom style`: a supplied reference script or a request to reproduce a style. Extract only an abstract, editable profile covering structure, roles, pace, tone, density, transitions, and ending. Never retain distinctive phrases, named hosts, identity traits, or branded language. Read [custom style](references/styles/custom-style.md).

When no route is explicit, recommend the best route and list at most two alternatives in the topic-and-style proposal. Include one primary presentation form and at most one alternative; this presentation recommendation is applied automatically after browser handoff and does not create a separate Host or voice question. A custom-style profile is written only after explicit approval, under `podcast-style-profiles/<profile-name>.md` in the current workspace.

## Production Contract

Podcastor's complete workflow supports one or two hosts. Reject or convert a three- or four-host request before drafting for Podcastor. The import-ready script contains only:

```text
Title: <title>

A: <spoken line>
B: <spoken line>
```

Use only `A` for a solo episode. Every line is spoken language only: no timecodes, stage directions, sound cues, citations, source lists, Markdown fences, commentary, or speaker labels other than `A` and `B`. Keep metadata outside this block. Read [duration bands](references/duration-bands.md) to select a Podcastor band and estimate the spoken body at 250-350 Chinese characters per minute or 120-160 words per minute for alphabetic languages; do not pad to hit a number. A requested 3-minute Podcastor episode maps to the shortest `~5min` band, while local-only output may remain exactly 3 minutes.

## Generate And Revise Locally

Read the selected style guide and [duration bands](references/duration-bands.md), choose the nearest production band, write the title and ordered dialogue, then validate language, host count, spoken-body count, duration estimate, and the spoken-only contract. Natural requests such as “shorten 30%,” “make B more skeptical,” or “change to English” revise the current script in Codex. Preserve title and valid labels unless the user requests a change. Do not overwrite an existing Podcastor project after a revision unless explicitly asked to update it.

## Automatic Podcastor Studio Handoff

After the user confirms the browser handoff for a new non-local-only script, immediately read [the browser workflow](references/podcastor-browser-workflow.md), open Podcastor Studio, choose **Start from scratch**, and enter the generated dialogue directly into the editor. Strip the `A:`/`B:` prefixes, create one `New Paragraph` for every dialogue line, and switch the paragraph's host so `A` maps to Host 1 and `B` maps to Host 2. Keep a verified TXT under `.podcastor-imports/` only as a local audit/export artifact.

Treat editor entry as a loss-sensitive loop: never bulk-paste a full script into one textbox. For each line, confirm the current paragraph, add the next paragraph through the current dialogue item's **New Paragraph** control, verify the visible Host 1/Host 2 label, switch with **Switch role** when it does not match, enter spoken text only, and click **Confirm** before continuing. Re-read the visible paragraph count and host sequence after the loop.

After the script is entered, automatically apply the recommended form, camera treatment, existing hosts, and voices. Do not ask the user to choose among ordinary reversible settings. If a recommended option is unavailable, use the closest visible existing option and report the substitution. Never create a new avatar in this automatic path; use an existing host.

After the handoff confirmation, show the visible configuration and cost, then automatically run `Render Audio`, wait for completion, run `Render Video`, and use the matching project's `Download Video` control. The project's `video_url` is the source of truth: return the exact URL opened by the download control as the final video download URL, or return the exposed `video_url` when the browser records only the source URL. Do not wait for a filesystem download artifact. Keep the Studio project URL separate and never report it as the video URL. If opening the download creates a browser-connection reset, reconnect to the same session, re-identify the exact completed project by title, and extract its media URL; do not restart rendering or substitute a different project's link.

## Common Mistakes

- Do not use a Podcastor backend API to generate the script.
- Do not route a local-only request into Studio.
- Do not claim a setting, render, or media URL before it is visible in the page.
- Do not bypass authentication, CAPTCHA, credits, usage limits, or warning dialogs.
- Do not copy identifying language when creating a custom style profile.
