#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
file="$root/skills/podcast-creator/SKILL.md"
test -f "$file"
grep -qx -- "---" <(head -n 1 "$file")
grep -q "^name: podcast-creator$" "$file"
grep -q "^description: Use when" "$file"

public_skill_count="$(find "$root/skills" -type f -name SKILL.md | wc -l | tr -d ' ')"
test "$public_skill_count" -eq 1
test "$(find "$root/skills" -type f -name SKILL.md)" = "$file"

for style in adaptive storytelling debate custom-style; do
  test -f "$root/skills/podcast-creator/references/styles/$style.md"
  grep -q "^# " "$root/skills/podcast-creator/references/styles/$style.md"
done

test -f "$root/skills/podcast-creator/references/styles/style-profile-format.md"
test ! -e "$root/skills/adaptive-podcast-script"
test ! -e "$root/skills/storytelling-podcast-script"
test ! -e "$root/skills/debate-podcast-script"
test ! -e "$root/skills/custom-style-podcast-script"

grep -q "one or two hosts" "$root/skills/podcast-creator/SKILL.md"
grep -q "metadata outside the import-ready script" "$root/skills/podcast-creator/SKILL.md"
! grep -q '^Language: <language> | Hosts:' "$root/skills/podcast-creator/SKILL.md"
grep -q "references/styles/adaptive.md" "$file"
grep -q "references/styles/storytelling.md" "$file"
grep -q "references/styles/debate.md" "$file"
grep -q "references/styles/custom-style.md" "$file"
grep -q "Debate always uses exactly two hosts" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "explicit user approval" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "podcast-style-profiles/<profile-name>.md" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "outside the current workspace" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "Podcast Format Decision Matrix" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "Hybrid Format Rules" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "Insufficient Material Strategy" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "Common Failure Modes" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "Safety Boundaries" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "simplified Chinese when Chinese is requested" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "redesign the listener's cognitive path" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "Cold-Open Hook" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "Information Release Rules" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "present-time suspense + past backfill" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "Resonant Ending" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "Common Failure Modes" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "simplified Chinese when Chinese is requested" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "who bore the cost" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "people or character perspectives" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "The goal is not to create noise" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Internal Debate Modeling" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Cross-Examination" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Definition Challenge" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Factual and Safety Boundaries" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "simplified Chinese when Chinese is requested" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Prefer official and primary sources" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "At introductory depth" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "Style Fingerprint Dimensions" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "Style Transfer Rules" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "Insufficient Material Strategy" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "Treat target duration as a production constraint" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "Treat target duration as a production constraint" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "Treat target duration as a production constraint" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "supports one or two hosts only" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "solo episode uses \`A\`" "$root/skills/podcast-creator/references/styles/adaptive.md"
grep -q "supports one or two hosts" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "solo episode uses \`A\`" "$root/skills/podcast-creator/references/styles/storytelling.md"
grep -q "exactly two hosts" "$root/skills/podcast-creator/references/styles/debate.md"
grep -q "supports one or two hosts" "$root/skills/podcast-creator/references/styles/custom-style.md"

for style in adaptive storytelling debate custom-style; do
  ! grep -Eiq 'one[ -]to[ -]four hosts|1[ -]to[ -]4 hosts|1-4 hosts|A, B, C|A/B/C/D' \
    "$root/skills/podcast-creator/references/styles/$style.md"
done
grep -q "login, registration, verification, CAPTCHA" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "avatar" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Render Audio" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Render Video" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"

node - "$root/evals/evals.json" <<'NODE'
const fs = require('fs')
const manifest = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'))
const ids = new Set(manifest.evals.map((item) => item.id))
const required = [
  'adaptive-two-host',
  'debate-host-limit',
  'custom-style-consent',
  'revision-contract',
  'browser-confirmation',
  'storytelling-solo'
]

if (!manifest.evaluation_method || manifest.evals.length !== required.length) process.exit(1)
if (manifest.skill_name !== 'podcast-creator') process.exit(1)
for (const id of required) if (!ids.has(id)) process.exit(1)
for (const item of manifest.evals) {
  if (!item.prompt || !item.baseline_risk || !Array.isArray(item.assertions) || !item.assertions.length) {
    process.exit(1)
  }
}
NODE

if LC_ALL=C grep -n '[^ -~]' "$root"/skills/podcast-creator/references/styles/*.md; then
  echo "Style references must contain the English translation only." >&2
  exit 1
fi

echo "Podcast Creator skill bundle structure is valid."
