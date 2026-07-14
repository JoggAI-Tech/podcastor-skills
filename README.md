# Podcast Creator Skill Bundle

This repository contains one local Codex skill for producing Podcast scripts and sending approved one- or two-host episodes through the Podcastor browser workflow.

## Included Skill

- `podcast-creator`: Coordinates source collection, local generation, revisions, and the confirmed Podcastor handoff. It contains four internal, on-demand style guides: adaptive, storytelling, debate, and custom style.

The bundle creates scripts locally. It does not call the Podcastor backend script API. Podcastor is used only to import an approved script, select voices and avatars, generate audio, and render video.

## Install

Copy the single `podcast-creator` directory into `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills
cp -R skills/podcast-creator ~/.agents/skills/
```

Restart or refresh Codex after installation so it discovers the `podcast-creator` skill. It reads only the matching internal style guide for each episode.

## Production Limits

Podcastor's current end-to-end workflow supports one or two hosts. All import-ready scripts use only `A:` and `B:` labels, contain spoken dialogue only, and omit timecodes, sound cues, and stage directions.

Codex asks for a content source first, then style, host count, language, and optional duration. It keeps the script available for natural-language revisions. A style profile is saved only after the user approves it, at `podcast-style-profiles/<profile-name>.md` in the current workspace. Alternate locations must remain within that workspace.

The browser handoff asks for confirmation before account actions, avatar creation, audio generation that may consume credits, and video rendering.

## Validate

```bash
bash tests/validate_bundle.sh
```

The discriminating evaluation prompts are stored in `evals/evals.json`.
