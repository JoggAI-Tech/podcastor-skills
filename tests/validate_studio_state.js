const assert = require('node:assert/strict')

function studioState({ started, titleSet, paragraphs, expectedTurns, roles, expectedRoles, saved }) {
  if (!started) return 'not-started'
  if (!titleSet || paragraphs !== expectedTurns || roles.join(',') !== expectedRoles.join(',')) return 'editing'
  if (!saved) return 'editing'
  return 'ready'
}

function editorPlan(lines) {
  return lines.map((line) => ({
    host: line.startsWith('A:') ? 'Host 1' : 'Host 2',
    text: line.replace(/^[AB]:\s*/, ''),
  }))
}

function canAutoConfigure({ existingHost, visibleForm, visibleVoicePair }) {
  return Boolean(existingHost && visibleForm && visibleVoicePair)
}

assert.equal(studioState({}), 'not-started')
assert.equal(studioState({ started: true, titleSet: false, paragraphs: 2, expectedTurns: 2, roles: ['Host 1', 'Host 2'], expectedRoles: ['Host 1', 'Host 2'], saved: true }), 'editing')
assert.equal(studioState({ started: true, titleSet: true, paragraphs: 1, expectedTurns: 2, roles: ['Host 1'], expectedRoles: ['Host 1', 'Host 2'], saved: true }), 'editing')
assert.equal(studioState({ started: true, titleSet: true, paragraphs: 2, expectedTurns: 2, roles: ['Host 1', 'Host 1'], expectedRoles: ['Host 1', 'Host 2'], saved: true }), 'editing')
assert.equal(studioState({ started: true, titleSet: true, paragraphs: 2, expectedTurns: 2, roles: ['Host 1', 'Host 2'], expectedRoles: ['Host 1', 'Host 2'], saved: true }), 'ready')
assert.deepEqual(editorPlan(['A: first line', 'B: second line']), [
  { host: 'Host 1', text: 'first line' },
  { host: 'Host 2', text: 'second line' },
])
assert.equal(canAutoConfigure({ existingHost: true, visibleForm: true, visibleVoicePair: true }), true)
assert.equal(canAutoConfigure({ existingHost: false, visibleForm: true, visibleVoicePair: true }), false)
