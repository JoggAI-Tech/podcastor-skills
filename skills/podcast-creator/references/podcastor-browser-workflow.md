# Podcastor Browser Workflow

Use this workflow after a new one- or two-host script is generated and validated in the guided end-to-end creation flow. The workflow-level request authorizes script import for its first production-ready script; it does not authorize account actions or credit-consuming production actions. Do not use it for a local-only request or a draft still under revision.

Use the native `request_user_input` tool described in `SKILL.md` for every user-facing choice or confirmation in this workflow. Ask one question at a time, use the named ID below, and supply current visible options rather than inventing options that are not on the page. Use the documented JSON fallback only when the native tool is unavailable.

## Prepare The Exact File

1. Verify that the generated script has a title and only `A:` or `B:` spoken lines. Write the exact current title and dialogue, with one speaker turn per paragraph, to a fresh unique TXT under `.podcastor-imports/` in the current workspace. Read it back and compare it with the validated import-ready script before attaching it. Do not reuse a same-named file from an earlier episode.

## Upload And Convert

2. Open `https://podcastor.ai/video-podcast` with the in-app browser and inspect the current page rather than assuming labels or controls. Select `Upload Script`, then the `Click to Upload` drop area. The current UI accepts script files in PDF, DOCX, or TXT format up to 50 MB. Use TXT for a locally generated script; do not convert the script into audio merely to upload it.
3. At any point, if the site requires sign-in, stop. Treat login, registration, verification, CAPTCHA, or credential entry as the same boundary. The user must complete those steps themselves and tell the agent when they are done. Do not ask for or collect those values in a structured question, and do not use the attachment path to bypass an authentication boundary.
4. The agent owns attachment of the prepared TXT. First use a supported browser file-input or attachment capability. If it is unavailable, check whether Computer Use can operate the host application's native file picker before attempting it. If Computer Use is denied access to the Codex Desktop host app, treat that as a native-picker capability failure and do not retry it. The workflow request authorizes the upload; do not ask the user to locate or select the file as the normal path.
5. If both direct attachment and native-picker operation are unavailable because of a concrete platform restriction, report the unavailable capabilities, keep the upload page and verified TXT available, and use an `attachment_takeover` native confirmation with no free-form option as the last fallback to let the user confirm that they selected the prepared file or cancel the upload. Do not claim that the file was selected, attached, or that import started.
6. Treat the file as selected or attached only when the page visibly shows the exact prepared file name and an enabled `Next` button. Before this state, do not say that the file is selected or attached.
7. Click `Next` only after the selected-state check passes. This starts the import and creates or opens the Studio project, but it does not authorize voice, avatar, audio, or video production.
8. Wait for the conversion state in Studio. The current UI reports `Convert pdf/audio to Script...` with a percentage and staged progress such as processing material content, extracting script text, assigning roles, and finalizing episode content. Do not treat the import as complete until that state is gone and the Studio shows the script with its host controls. If conversion fails, report the visible failure and keep the verified local script available for correction.

The UI can also convert MP3, WAV, or M4A audio to a script. That is a separate audio-source path, not the route for a locally generated TXT script.

## Continue Gate

9. Once conversion succeeds, use a `continue_studio` native question with options to continue setup or stop at the imported script. Stop here until the user explicitly agrees. Do not select a form, visual treatment, host, voice, audio render, or video render before the user continues.

## Studio Setup After Continue

10. For a solo script, use `Solo` and map `A` to Host 1. For a two-host script, use a `studio_form` native question after inspecting the available options. The current Studio navigation includes `Talk Show`, `Split Screen`, `Two-Shot`, `Cartoon`, `Pet`, and `Visual`; do not assume a form has been selected solely from a previous project state.
11. In the Video Preview area, use `host_presentation` and `camera_treatment` native questions for the visible existing host presentations and camera treatments such as `Alternating shots` or `Speaker focus`. The preview also exposes existing host cards and `Create New Podcast Host`. Selecting an existing host is reversible; use a `create_avatar` native confirmation only after showing the available method and visible cost.
12. Map `A` to `Host 1` and `B` to `Host 2` in the voice bar. Use a `voice_selection` native question for the visible voices or voice pairs, then confirm that the selected host count and voice assignments still match the script before any rendering action.

## Render Boundaries

13. Before `Render Audio` in the bottom action bar, show the selected voices and visible credit estimate. Use a `render_audio` native confirmation before clicking it. Wait for the page to report success or failure.
14. Before `Render Video` in the Studio header, show the selected form, camera treatment, hosts, aspect ratio, and visible credit estimate. Use a `render_video` native confirmation before clicking it. After a confirmed production action, wait for the result state and report the resulting project or media link when available; otherwise report the surfaced error and keep the current script available for correction.

Never bypass authentication, CAPTCHA, payment, usage limits, or warning dialogs. Do not use a product API as a substitute for this browser flow.
