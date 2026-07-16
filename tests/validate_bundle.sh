#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
skill="$root/skills/podcast-creator/SKILL.md"
workflow="$root/skills/podcast-creator/references/podcastor-browser-workflow.md"

test -f "$skill"
grep -qx -- "---" <(head -n 1 "$skill")
grep -q '^name: podcast-creator$' "$skill"
grep -q '^description: Use when' "$skill"

public_skill_count="$(find "$root/skills" -type f -name SKILL.md | wc -l | tr -d ' ')"
test "$public_skill_count" -eq 1

for style in adaptive storytelling debate custom-style; do
  style_file="$root/skills/podcast-creator/references/styles/$style.md"
  test -f "$style_file"
  grep -q '^# ' "$style_file"
done
test -f "$root/skills/podcast-creator/references/styles/style-profile-format.md"
test -f "$root/skills/podcast-creator/references/duration-bands.md"
test -f "$root/skills/podcast-creator/references/topic-deep-research.md"
test ! -e "$root/skills/adaptive-podcast-script"
test ! -e "$root/skills/storytelling-podcast-script"
test ! -e "$root/skills/debate-podcast-script"
test ! -e "$root/skills/custom-style-podcast-script"

grep -q 'Required Interactions' "$skill"
grep -q 'minimum missing topic information' "$skill"
grep -q 'topic-and-style confirmation' "$skill"
grep -q 'recommend one script style' "$skill"
grep -q 'Podcastor presentation form' "$skill"
grep -q '`Solo`, `Talk Show`, `Split Screen`, `Two-Shot`, `Cartoon`, `Pet`, or `Visual`' "$skill"
grep -q 'mandatory Deep Research (DeepReach)' "$skill"
grep -q 'scored topic plan' "$skill"
grep -q 'browser-handoff confirmation' "$skill"
grep -q 'Do not ask again for those actions' "$skill"
grep -q 'Start from scratch' "$skill"
grep -q 'choose \*\*Start from scratch\*\*' "$skill"
grep -q 'Do not use a Podcastor backend API' "$skill"
grep -q 'one or two hosts' "$skill"
grep -q 'metadata outside this block' "$skill"
grep -q 'Render Audio' "$skill"
grep -q 'Render Video' "$skill"
grep -q 'final video download URL' "$skill"
grep -q "project's \`video_url\`" "$skill"
grep -q 'automatically run `Render Audio`' "$skill"
grep -q "matching project's \`Download Video\` control" "$skill"
grep -q 'duration bands' "$skill"
grep -q 'default to `~5min`' "$skill"

grep -q 'Start from scratch' "$workflow"
grep -q 'directly into the editor' "$workflow"
grep -q 'New Paragraph' "$workflow"
grep -q 'Remove the source `A:`/`B:` prefix' "$workflow"
grep -q 'never type speaker labels' "$workflow"
grep -q 'host assignment sequence' "$workflow"
grep -q 'dialogue-item' "$workflow"
grep -q 'following sibling `div.group.cursor-pointer`' "$workflow"
grep -q 'switch-host-icon' "$workflow"
grep -q 'button\[aria-label="Confirm"\]' "$workflow"
grep -q 'count increased by exactly one' "$workflow"
grep -q 'Talk Show' "$workflow"
grep -q 'Alternating shots' "$workflow"
grep -q 'Speaker focus' "$workflow"
grep -q 'Split Screen' "$workflow"
grep -q 'Two-Shot' "$workflow"
grep -q 'Cartoon' "$workflow"
grep -q 'Pet' "$workflow"
grep -q 'Visual' "$workflow"
grep -q 'Host 1' "$workflow"
grep -q 'Host 2' "$workflow"
grep -q 'Render Audio' "$workflow"
grep -q 'Render Video' "$workflow"
grep -q 'Automatic Rendering And Download' "$workflow"
grep -q 'without another question' "$workflow"
grep -q 'handoff confirmation authorizes the audio render' "$workflow"
grep -q 'Voice selection creates no new confirmation point' "$workflow"
grep -q 'return it as the final video download URL' "$workflow"
grep -q "matching project's \`video_url\`" "$workflow"
grep -q 'Do not wait for a filesystem download event' "$workflow"
grep -q 'current browser tab URL' "$workflow"
grep -q 'matching project card by the exact title' "$workflow"
grep -q 'Never use a media URL from another card' "$workflow"
grep -q 'Hover that exact completed card' "$workflow"
grep -q 'Download Video' "$workflow"
grep -q 'Download Audio' "$workflow"
grep -q 'Download Subtitles' "$workflow"
! grep -q 'continue_studio' "$workflow"
! grep -q 'studio_form.*question' "$workflow"
! grep -q 'ask for explicit confirmation' "$workflow"
grep -q 'choose \*\*Start from scratch\*\*' "$workflow"
grep -q '7~12min' "$workflow"
grep -q '23~30min' "$workflow"
! grep -Eiq 'Upload Script|Convert pdf/audio|conversion-progress|conversion progress' "$skill" "$workflow"

for style in adaptive storytelling debate custom-style; do
  ! grep -Eiq 'one[ -]to[ -]four hosts|1[ -]to[ -]4 hosts|1-4 hosts|A, B, C|A/B/C/D' \
    "$root/skills/podcast-creator/references/styles/$style.md"
done
grep -q 'Debate always uses exactly two hosts' "$root/skills/podcast-creator/references/styles/debate.md"
grep -q 'explicit user approval' "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q 'podcast-style-profiles/<profile-name>.md' "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q '1,250-1,750' "$root/skills/podcast-creator/references/duration-bands.md"
grep -q '5,750-10,500' "$root/skills/podcast-creator/references/duration-bands.md"
grep -q '3-6 minutes' "$root/skills/podcast-creator/references/duration-bands.md"
grep -q 'Score each candidate from 0 to 5' "$root/skills/podcast-creator/references/topic-deep-research.md"
grep -q 'total out of 40' "$root/skills/podcast-creator/references/topic-deep-research.md"
grep -q 'Multi-Angle Analysis' "$root/skills/podcast-creator/references/topic-deep-research.md"
grep -q 'Production Plan' "$root/skills/podcast-creator/references/topic-deep-research.md"
grep -q 'duration-bands.md' "$root/skills/podcast-creator/references/topic-deep-research.md"

node "$root/tests/validate_studio_state.js"

node - "$root/evals/evals.json" <<'NODE'
const fs = require('node:fs')
const manifest = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'))
if (manifest.skill_name !== 'podcast-creator' || !manifest.evaluation_method) process.exit(1)
if (!Array.isArray(manifest.evals) || manifest.evals.length < 10) process.exit(1)
for (const item of manifest.evals) {
  if (!item.id || !item.prompt || !item.baseline_risk || !Array.isArray(item.assertions) || item.assertions.length === 0) process.exit(1)
}
NODE

if LC_ALL=C grep -n '[^ -~]' "$root"/skills/podcast-creator/references/styles/*.md; then
  echo "Style references must contain the English translation only." >&2
  exit 1
fi

echo "Podcast Creator skill bundle structure is valid."
