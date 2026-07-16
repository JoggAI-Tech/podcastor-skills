const assert = require('node:assert/strict')

function uploadState({ fileName, nextEnabled, nextClicked, conversionComplete, parsedScript, hostControls }) {
  if (!fileName || !nextEnabled) return 'awaiting-attachment'
  if (!nextClicked) return 'selected'
  if (!conversionComplete || !parsedScript || !hostControls) return 'converting'
  return 'imported'
}

function requiresUserTakeover({ directAttachment, nativePickerControl }) {
  return !directAttachment && !nativePickerControl
}

assert.equal(uploadState({}), 'awaiting-attachment')
assert.equal(uploadState({ fileName: 'episode.txt', nextEnabled: false }), 'awaiting-attachment')
assert.equal(uploadState({ fileName: 'episode.txt', nextEnabled: true }), 'selected')
assert.equal(uploadState({ fileName: 'episode.txt', nextEnabled: true, nextClicked: true }), 'converting')
assert.equal(uploadState({ fileName: 'episode.txt', nextEnabled: true, nextClicked: true, conversionComplete: true, parsedScript: true, hostControls: true }), 'imported')
assert.equal(requiresUserTakeover({ directAttachment: true, nativePickerControl: false }), false)
assert.equal(requiresUserTakeover({ directAttachment: false, nativePickerControl: true }), false)
assert.equal(requiresUserTakeover({ directAttachment: false, nativePickerControl: false }), true)
