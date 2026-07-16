# Podcast Creator Skill Bundle

This repository contains one local Codex skill for producing Podcast scripts and sending one- or two-host episodes through Podcastor Studio's direct editor workflow.

## Included Skill

- `podcast-creator`: Selects a topic and style from the request, generates and revises scripts locally, then opens Podcastor Studio and enters the first validated script through **Start from scratch**. It automatically recommends the show form, camera treatment, existing hosts, and voices. It contains four internal, on-demand style guides: adaptive, storytelling, debate, and custom style.

The bundle creates scripts locally. It does not call the Podcastor backend script API. Podcastor is used only to enter the validated script in Studio, select voices and avatars, generate audio, and render video.

## Install

Copy the single `podcast-creator` directory into `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills
cp -R skills/podcast-creator ~/.agents/skills/
```

Restart or refresh Codex after installation so it discovers the `podcast-creator` skill. It reads only the matching internal style guide for each episode.

## Production Limits

Podcastor's current end-to-end workflow supports one or two hosts. All import-ready scripts use only `A:` and `B:` labels, contain spoken dialogue only, and omit timecodes, sound cues, and stage directions.

The workflow does not ask routine intent, source, style, host, language, duration, or continuation questions. It infers missing values, maps Podcastor production to the supported `~5min`, `7~12min`, `13~17min`, `18~22min`, or `23~30min` bands, and reports the estimated spoken Chinese characters or English words. The shortest band is the default; a local-only script may use an exact duration. It keeps the script available for natural-language revisions. A style profile is saved only after the user approves it, at `podcast-style-profiles/<profile-name>.md` in the current workspace. The browser handoff uses existing hosts and authorizes rendering and export; login, registration, verification, and CAPTCHA are the only user-completed boundaries.

After a new script is generated and validated in the end-to-end flow, Codex automatically opens Podcastor Studio, chooses **Start from scratch**, strips the `A:`/`B:` labels, creates one **New Paragraph** per turn, and switches each paragraph to Host 1 or Host 2 in the original order. It then applies the recommended form, camera treatment, existing hosts, and voices without routine questions. A fresh TXT is still written and verified as a local audit artifact. After rendering, Codex invokes **Download Video** on the matching completed project and returns the actual video download URL derived from that project's `video_url`, never the Studio page URL. The browser handoff asks only for authentication completion, new-avatar creation, audio rendering, and video rendering where required.

## Validate

```bash
bash tests/validate_bundle.sh
```

The discriminating evaluation prompts are stored in `evals/evals.json`.
