---
name: podcast-creator
description: Use when a user wants help choosing a Podcast topic, creating or revising a Podcast script, adapting a script style, or producing a Podcastor episode with voices, avatars, audio, or video. Guide users from topic selection through style recommendation and local script creation, then import the first validated production-ready script into Podcastor unless they request a local-only script.
---

# Podcast Creator

Create the script locally in Codex. Use Podcastor to import the first production-ready script as part of the guided end-to-end creation flow; do not use a Podcastor backend script generator.

## Ask Structured Questions

When the workflow needs the user to choose, confirm, or supply a non-sensitive value, call the native `request_user_input` tool when it is exposed. Do not print JSON as a substitute when the tool is available. Pass one question at a time using this shape:

```json
{
  "questions": [
    {
      "header": "Start",
      "id": "podcast_intent",
      "question": "What would you like to do?",
      "options": [
        {
          "label": "Find a topic",
          "description": "Explore and choose an episode idea."
        },
        {
          "label": "Use existing material",
          "description": "Create an episode from supplied material."
        }
      ]
    }
  ]
}
```

The native tool owns the popup. Its question object has `header`, `id`, `question`, and `options`; do not pass `isOther` or `isSecret` to the native tool. The client can provide a free-form Other choice when appropriate. The tool is available only in surfaces that expose it, including Plan mode in this environment.

If the native tool is unavailable, fall back to exactly one valid JSON object in this shape and no surrounding Markdown or explanatory text:

```json
{
  "id": "podcast_intent",
  "header": "Start a Podcast",
  "question": "What would you like to do?",
  "options": [
    {
      "label": "Find a topic",
      "description": "Explore and choose an episode idea."
    },
    {
      "label": "Use existing material",
      "description": "Create an episode from text, a file, a URL, or a supplied topic."
    }
  ],
  "isOther": true,
  "isSecret": false
}
```

Use a lowercase ASCII `id` that identifies the decision and is unique among prompts in the current episode, such as `podcast_intent`, `topic_selection`, `script_style`, `host_count`, `language`, `duration`, `continue_studio`, `create_avatar`, `render_audio`, or `render_video`. If asking the same decision again, use a new ID such as `topic_selection_retry`. Keep `header`, `question`, labels, and descriptions in the user's requested language. Provide two to five distinct options. In the fallback object, set `isOther` to `true` whenever free-form input is useful or required, and otherwise set it to `false`; set `isSecret` to `false` for this workflow.

Do not ask for passwords, one-time codes, CAPTCHA answers, payment details, or credentials in a structured question. At authentication boundaries, stop and ask the user to complete the action in the site themselves; do not request those values. When neither native input nor fallback rendering is interactive, the user may reply with an option label, an option index, or their own input when fallback `isOther` is `true`.

## Determine The User Intent

Identify an explicit intent from the user's request. When it is ambiguous, ask one `podcast_intent` native question instead of immediately asking for a topic. Its options are:

1. Find a topic and create a Podcastor episode.
2. Create a Podcast from an existing topic or source.
3. Turn a reference script into a personal abstract style.
4. Revise the current script.
5. Continue an existing Podcastor project.

Treat options 1 and 2 as the end-to-end creation flow unless the user explicitly asks for a local-only script. Choosing that flow authorizes import of its first production-ready script. Do not ask the user to choose again when their request already makes the intent clear.

## Select The Topic

For a new episode, collect a content source unless it is already supplied. Use a `content_source` native question with source-type options and allow free-form input; set `isOther: true` only in the fallback object. Accept pasted text, an attached file, a URL that can be read, or a topic. Do not claim to have read inaccessible material.

When the user wants help finding a topic, collect only the missing editorial constraints, such as audience, subject area, desired freshness, and intended outcome, one native question at a time. Then offer three to five topic candidates. For each candidate, give a concise title, a one-sentence angle, and why it fits the stated audience or source. Return those candidates in one `topic_selection` native question: the candidate title is the label, the angle and rationale form the description, and allow free-form input. Set `isOther` to `true` only in the fallback object. When current or external reporting is used, distinguish verified facts from the editorial recommendation and never invent unavailable source details.

Wait for the user to choose, edit, or confirm one topic before drafting a script. A clear supplied topic or an explicit structured-option selection counts as confirmation.

## Recommend The Script Style

After the topic is confirmed, recommend one primary style and, when useful, up to two alternatives. Explain the recommendation in one or two sentences using the content goal, source type, audience, and intended listener experience. Use these high-level routes:

- `adaptive` for an explanation, analysis, news commentary, product topic, or general discussion.
- `storytelling` for a case, history, character, sequence of events, or narrative reveal.
- `debate` for a genuinely contestable question with two credible positions; it requires two hosts.
- `custom style` when the user supplies or reuses a personal style profile.

Present the recommendation, then use a `script_style` native question to let the user accept it or choose another supported style. Collect missing host count, language, and duration in separate `host_count`, `language`, and `duration` native questions. Defaults are `adaptive`, two hosts, simplified Chinese, and three minutes. In fallback objects, use `isOther: false` for host count and `isOther: true` for language and duration. Do not ask for a value already supplied by the user. Select one style guide and read only that guide before writing:

   - Read [adaptive](references/styles/adaptive.md) for a general episode or when no explicit form is chosen.
   - Read [storytelling](references/styles/storytelling.md) for a narrative, case, history, or character-driven episode.
   - Read [debate](references/styles/debate.md) for a contested question. It requires two hosts.
   - Read [custom style](references/styles/custom-style.md) when the user supplies a reference script or asks to create, refine, or reuse a personal style.

For a revision, keep the current episode context and change only what the user requests. Recheck the output contract after every revision. Do not automatically replace an already uploaded script unless the user asks to update it.

## Production Contract

Podcastor currently supports one or two hosts throughout its script, TTS, avatar, and video workflow. Never silently create a three- or four-host script for a Podcastor handoff. Use a `host_count` native question to offer a one- or two-host adaptation instead.

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

## Automatically Hand Off A New Script

After generating and validating a new production-ready script in the end-to-end creation flow, immediately read [the browser workflow](references/podcastor-browser-workflow.md), open Podcastor, and import or upload the exact current script. Do not pause for a separate script-approval step or require a second "send to Podcastor" request. Do not open Podcastor for a local-only script request or while the user is still revising a draft.

The end-to-end creation request authorizes populating or uploading its first validated production-ready script. It does not authorize account creation, credential entry, CAPTCHA completion, avatar creation, credit-consuming audio generation, or video rendering. Use a native confirmation at each of those boundaries.

After the browser workflow confirms conversion is complete, the Studio shows the parsed script, and the host controls are available, use one `continue_studio` native question whose options clearly continue setup or stop at the imported script. Do not claim that upload succeeded, select voices, avatars, audio, video layout, or render actions before those conditions and the user's explicit continue response.

The agent owns attachment of the prepared TXT. First write a fresh, uniquely named workspace file from the exact current import-ready title and dialogue, then compare its contents with the validated script before attachment. Prefer a supported browser file-input or attachment capability. When that capability is unavailable, use Computer Use only after confirming it can operate the host application's native picker. In Codex Desktop, treat a Computer Use denial for the Codex host app as a concrete native-picker capability failure; do not retry that route.

Do not make manual file selection the normal path. If the runtime exposes neither attachment control nor permission to operate the host application's file picker, report the concrete platform limitation, keep the upload page and verified TXT available, and ask the user to take over only as the last fallback. The file is selected or attached only when the page visibly shows the exact file name and an enabled `Next` action. Never claim selected, attached, uploaded, or imported before that state; reserve uploaded or imported for conversion completion in Studio.

## Common Mistakes

- Do not use a Podcastor backend script API to generate the script. The bundle generates locally.
- Do not present an unsupported multi-host script as ready for Podcastor.
- Do not upload a draft while the user is still revising it, or metadata mixed into the import-ready script.
- Do not create or save a personal style profile until the user expressly approves it.
