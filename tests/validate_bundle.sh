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
grep -q "explicitly says to save" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "podcast-style-profiles/<profile-name>.md" "$root/skills/podcast-creator/references/styles/custom-style.md"
grep -q "outside the current workspace" "$root/skills/podcast-creator/references/styles/custom-style.md"
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

echo "Podcast Creator skill bundle structure is valid."
