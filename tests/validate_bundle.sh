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
grep -q "Determine The User Intent" "$root/skills/podcast-creator/SKILL.md"
grep -q "Find a topic and create a Podcastor episode" "$root/skills/podcast-creator/SKILL.md"
grep -q "Select The Topic" "$root/skills/podcast-creator/SKILL.md"
grep -q "Recommend The Script Style" "$root/skills/podcast-creator/SKILL.md"
grep -q "Automatically Hand Off A New Script" "$root/skills/podcast-creator/SKILL.md"
grep -q "Do not pause for a separate script-approval step" "$root/skills/podcast-creator/SKILL.md"
grep -q "require a second \"send to Podcastor\" request" "$root/skills/podcast-creator/SKILL.md"
grep -q '`continue_studio` native question' "$root/skills/podcast-creator/SKILL.md"
grep -q "validated production-ready script" "$root/skills/podcast-creator/SKILL.md"
grep -q "conversion is complete, the Studio shows the parsed script, and the host controls are available" "$root/skills/podcast-creator/SKILL.md"
grep -q "The agent owns attachment of the prepared TXT" "$root/skills/podcast-creator/SKILL.md"
grep -q "Do not make manual file selection the normal path" "$root/skills/podcast-creator/SKILL.md"
grep -q "write a fresh, uniquely named workspace file" "$root/skills/podcast-creator/SKILL.md"
grep -q "exact file name and an enabled \`Next\` action" "$root/skills/podcast-creator/SKILL.md"
grep -q "Computer Use denial for the Codex host app" "$root/skills/podcast-creator/SKILL.md"
grep -q "Ask Structured Questions" "$root/skills/podcast-creator/SKILL.md"
grep -q 'call the native `request_user_input` tool' "$root/skills/podcast-creator/SKILL.md"
grep -q 'The native tool owns the popup' "$root/skills/podcast-creator/SKILL.md"
grep -q 'do not pass `isOther` or `isSecret` to the native tool' "$root/skills/podcast-creator/SKILL.md"
grep -q 'fall back to exactly one valid JSON object' "$root/skills/podcast-creator/SKILL.md"
grep -q '"id": "podcast_intent"' "$root/skills/podcast-creator/SKILL.md"
grep -q '"isOther": true' "$root/skills/podcast-creator/SKILL.md"
grep -q '"isSecret": false' "$root/skills/podcast-creator/SKILL.md"
grep -q 'Do not ask for passwords, one-time codes, CAPTCHA answers, payment details, or credentials' "$root/skills/podcast-creator/SKILL.md"
grep -q 'ask one `podcast_intent` native question' "$root/skills/podcast-creator/SKILL.md"
grep -q 'one `topic_selection` native question' "$root/skills/podcast-creator/SKILL.md"
grep -q '`script_style` native question' "$root/skills/podcast-creator/SKILL.md"
grep -q '`continue_studio` native question' "$root/skills/podcast-creator/SKILL.md"
! grep -q "approved script" "$root/skills/podcast-creator/SKILL.md"
! grep -q "approved script" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
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
grep -q "workflow-level request authorizes script import" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q '`continue_studio` native question' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Upload And Convert" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Click to Upload" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Next" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Convert pdf/audio to Script" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "state is gone and the Studio shows the script with its host controls" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Use TXT for a locally generated script" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "separate audio-source path" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "The agent owns attachment of the prepared TXT" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "fresh unique TXT under \`.podcastor-imports/\`" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Computer Use is denied access to the Codex Desktop host app" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "exact prepared file name and an enabled \`Next\` button" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "At any point, if the site requires sign-in" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "last fallback" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Talk Show" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Alternating shots" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Speaker focus" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Host 1" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q "Host 2" "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q 'native `request_user_input` tool' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q 'documented JSON fallback' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q '`attachment_takeover` native confirmation' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q '`studio_form` native question' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q '`render_audio` native confirmation' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"
grep -q '`render_video` native confirmation' "$root/skills/podcast-creator/references/podcastor-browser-workflow.md"

node - "$root/skills/podcast-creator/references/podcastor-browser-workflow.md" <<'NODE'
const fs = require('fs')
const workflow = fs.readFileSync(process.argv[2], 'utf8')
const upload = workflow.indexOf('Upload And Convert')
const next = workflow.indexOf('`Next`')
const conversion = workflow.indexOf('Convert pdf/audio to Script')
const continueGate = workflow.indexOf('## Continue Gate')
const setup = workflow.indexOf('## Studio Setup After Continue')
const audio = workflow.indexOf('Before `Render Audio`')
const video = workflow.indexOf('Before `Render Video`')
if (upload < 0 || next < 0 || conversion < 0 || continueGate < 0 || setup < 0 || audio < 0 || video < 0) process.exit(1)
if (!(upload < next && next < conversion && conversion < continueGate && continueGate < setup && setup < audio && audio < video)) process.exit(1)
NODE

node "$root/tests/validate_upload_state.js"

node - "$root/skills/podcast-creator/SKILL.md" <<'NODE'
const assert = require('node:assert/strict')
const fs = require('fs')
const skill = fs.readFileSync(process.argv[2], 'utf8')
const blocks = [...skill.matchAll(/```json\n({[\s\S]*?})\n```/g)].map((match) => JSON.parse(match[1]))
const native = blocks.find((prompt) => Array.isArray(prompt.questions))
const fallback = blocks.find((prompt) => prompt.id && prompt.isOther !== undefined)
assert.ok(native, 'native request_user_input JSON example is missing')
assert.ok(fallback, 'fallback structured-question JSON example is missing')
assert.deepEqual(Object.keys(native), ['questions'])
assert.equal(native.questions.length, 1)
const question = native.questions[0]
assert.deepEqual(Object.keys(question), ['header', 'id', 'question', 'options'])
assert.match(question.id, /^[a-z][a-z0-9_]*$/)
assert.equal(typeof question.header, 'string')
assert.equal(typeof question.question, 'string')
assert.ok(Array.isArray(question.options) && question.options.length >= 2)
assert.ok(question.options.every((option) => typeof option.label === 'string' && typeof option.description === 'string'))
assert.deepEqual(Object.keys(fallback), ['id', 'header', 'question', 'options', 'isOther', 'isSecret'])
assert.equal(typeof fallback.isOther, 'boolean')
assert.equal(fallback.isSecret, false)
NODE

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
  'storytelling-solo',
  'guided-topic-selection',
  'automatic-script-handoff',
  'ambiguous-intent-options',
  'local-only-no-handoff',
  'revision-no-overwrite',
  'podcastor-ui-sequence',
  'agent-owned-script-upload',
  'upload-authentication-interrupt',
  'structured-render-confirmation'
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
