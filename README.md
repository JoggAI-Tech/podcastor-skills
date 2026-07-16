# Podcast Creator Skill Bundle

This repository contains one local Codex skill for producing Podcast scripts and sending approved one- or two-host episodes through the Podcastor browser workflow.

## Included Skill

- `podcast-creator`: Guides topic selection, recommends a script style, generates and revises scripts locally, and imports the first validated production-ready end-to-end script into Podcastor. It contains four internal, on-demand style guides: adaptive, storytelling, debate, and custom style.

The bundle creates scripts locally. It does not call the Podcastor backend script API. Podcastor is used only to import a validated production-ready script, select voices and avatars, generate audio, and render video.

## Install

Copy the single `podcast-creator` directory into `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills
cp -R skills/podcast-creator ~/.agents/skills/
```

Restart or refresh Codex after installation so it discovers the `podcast-creator` skill. It reads only the matching internal style guide for each episode.

## Production Limits

Podcastor's current end-to-end workflow supports one or two hosts. All import-ready scripts use only `A:` and `B:` labels, contain spoken dialogue only, and omit timecodes, sound cues, and stage directions.

For an ambiguous new request, Codex first offers intent choices: find a topic, create from existing material, create a personal style, revise a script, or continue a project. It calls the native `request_user_input` tool when available, clarifies blockers first, and batches up to three independent questions per call. Once enough information is available, it infers ordinary defaults instead of repeatedly asking. If the tool fails, it uses a compact normal plain-text question with numbered options rather than emitting JSON. For topic discovery it proposes candidates and waits for the user to confirm one. It then recommends a primary script style before collecting host count, language, and optional duration, combining independent production choices whenever possible. It keeps the script available for natural-language revisions. A style profile is saved only after the user approves it, at `podcast-style-profiles/<profile-name>.md` in the current workspace. Alternate locations must remain within that workspace.

After a new script is generated and validated in the end-to-end creation flow, Codex automatically opens Podcastor and imports the first version unless the user asks for a local-only script. The agent writes and verifies a fresh TXT before attempting browser attachment or, where supported, native-picker automation. In Codex Desktop, a Computer Use denial for the host app is treated as a concrete picker limitation rather than retried. User file selection is only a documented last fallback when both agent-controlled paths are unavailable. The user does not need to send a separate upload confirmation for that first version. Codex then asks whether to continue. The browser handoff asks for confirmation before account actions, avatar creation, audio generation that may consume credits, and video rendering.

## Validate

```bash
bash tests/validate_bundle.sh
```

The discriminating evaluation prompts are stored in `evals/evals.json`.
