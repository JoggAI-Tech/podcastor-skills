# Podcastor Browser Workflow

Use this workflow only after the user has confirmed browser handoff for a new one- or two-host script. The current Podcastor path is Studio's **Start from scratch** editor. A locally generated script is entered directly into the editor as host-assigned paragraphs.

Routine choices are agent-owned. Infer and apply the form, camera treatment, existing podcast hosts, and voices from the script and the recommendation matrix in `SKILL.md`. The handoff confirmation authorizes the audio render, video render, and completed-video download for this exact script. Pause only at login/registration/verification/CAPTCHA. Select existing hosts; do not create avatars. Never inspect or extract tokens, cookies, local storage, or credentials.

Use [duration bands](duration-bands.md) for the time control. Select `~5min`, `7~12min`, `13~17min`, `18~22min`, or `23~30min` when the visible control offers it. For a requested 3-6 minute Podcastor episode, select `~5min`; report the mapped band and estimated spoken character/word count before entering the script.

## Prepare The Script Artifact

1. Validate the current import-ready block: a title followed by spoken `A:`/`B:` lines, with no metadata or directions inside the dialogue. Write a fresh uniquely named TXT under `.podcastor-imports/` and read it back for an exact comparison. This is an audit/export artifact, not a file to attach through Podcastor.

## Start From Scratch

2. Open `https://podcastor.ai/studio/podcast-studio` in the in-app browser. If the page is on another Podcastor surface, use the visible **Studio** navigation item. Preserve existing projects; start a new project rather than replacing a prior episode.
3. In the start panel, choose **Start from scratch**.
4. Set the project title to the generated title when the title field is available. In the Script panel, parse the ordered local dialogue into individual `A:`/`B:` turns. The editor usually opens with one initial paragraph; use it for the first turn and create every later turn with the scoped **New Paragraph** control.

### Deterministic paragraph-entry loop

Run this loop for `i = 1..N` in source order. `N` must equal the number of dialogue lines.

1. For `i > 1`, finish the previous draft first: click the current paragraph's `button[aria-label="Confirm"]` and wait until the button is disabled or the text is visibly committed. Hover the interval immediately after the latest `.dialogue-item`; it is the following sibling `div.group.cursor-pointer` and reveals **New Paragraph**. Click that interval's control. Do not use a global `New Paragraph` locator because the page keeps hidden template copies. Confirm that the `.dialogue-item` count increased by exactly one.
2. Scope all operations to the new/latest `.dialogue-item`. Read its visible `Host 1`/`Host 2` label. If it differs from the expected host (`A` → Host 1, `B` → Host 2), click that item's `img.switch-host-icon` (**Switch role**) once and re-read the label. Never assume the editor inherited the previous host.
3. Activate that item's `div.editor-content[contenteditable="true"]` (the visible `tiptap.ProseMirror` textbox), replace its contents with the spoken text only, and ensure it contains one paragraph. Remove the source `A:`/`B:` prefix before typing; never type speaker labels, Markdown, or stage directions.
4. Click the same item's `button[aria-label="Confirm"]`. Wait for the edit state to close or become disabled, and verify the committed text before starting the next iteration.

For the first turn, skip step 1 if the initial paragraph already exists; otherwise create it with **New Paragraph**. For a solo script, perform the same loop with every paragraph on Host 1. If a click or text replacement would target a hidden element, stop and make the adjacent interval or paragraph visible by hovering it; do not force a hidden template or paste the entire script as a fallback.

5. Verify that the paragraph count equals `N`, the visible host assignment sequence matches the original `A`/`B` sequence, every paragraph contains spoken text without a speaker prefix, and the project shows a saved or otherwise accepted state. If a paragraph or host assignment is missing, correct it before configuration.

## Apply Automatic Recommendations

Use the primary presentation recommendation accepted in the topic-and-style proposal. The labels below are current UI examples and may change; inspect the page before clicking. `Script style` controls the writing; `form` controls the on-screen presentation. Do not confuse them or ask a second form-selection question.

| Script signal | Form | Camera treatment | Host and voice treatment |
| --- | --- | --- |
| Solo explanation or story | `Solo` | `Speaker focus` | One warm, clear existing host; conversational voice |
| Two-host adaptive analysis | `Talk Show` | `Alternating shots` | Host 1 calm/analytical; Host 2 curious/critical |
| Two-host storytelling | `Talk Show` | `Speaker focus` or `Alternating shots` when both hosts carry equal narrative weight | Host 1 warm narrator; Host 2 vivid but restrained companion |
| Two-host debate | `Talk Show` | `Alternating shots` | Host 1 authoritative case-maker; Host 2 skeptical challenger |
| Two-host remote interview or deliberate side-by-side contrast | `Split Screen` | `Speaker focus` | Distinct but balanced existing hosts; clear contrasting roles |
| Intimate two-host conversation or shared reaction | `Two-Shot` | `Speaker focus` | Hosts with compatible, conversational presence |
| Light, family-friendly animal or companion-led episode | `Pet` | Match the selected pet scene | Warm, playful existing voices; use only when the topic supports it |
| Playful, youth-oriented, imaginative, or simplified explainer | `Cartoon` | Match the selected animated scene | Expressive but clear existing voices |
| Data-led explainer, visual narrative, or slide-like walkthrough | `Visual` | Match the selected visual treatment | Clear explanatory voices; prioritize legibility over character performance |
| Custom style | Match the profile's structure; default to `Talk Show` | Match the profile's pacing; default to `Alternating shots` | Match abstract role and tone traits only |

6. In the left Studio rail, select the recommended form (`Talk Show`, `Solo`, `Split Screen`, `Two-Shot`, `Cartoon`, `Pet`, or `Visual`) when it exists. In the preview, select the recommended treatment such as **Alternating shots** or **Speaker focus**.
7. Choose existing podcast hosts that fit the recommended roles. The preview may show **Create New Podcast Host** and existing host cards. Select the closest visible existing host and never create a new one in this automatic path.
8. In the voice bars, map Host 1 to `A` and Host 2 to `B`. Select the closest visible voices to the recommended traits, then verify that the number of assignments matches the script. Voice selection creates no new confirmation point; continue to automatic rendering under the browser-handoff confirmation.

## Automatic Rendering And Download

9. Report the visible Host 1/Host 2 voices and credit estimate, then click **Render Audio** without another question. Wait for a completed player/download control or a surfaced failure. Do not treat a loading state as success.
10. Report the visible form, camera treatment, host assignments, voices, aspect ratio, and credit estimate, then click **Render Video** without another question. Wait for a completed result or a surfaced failure. The current UI can return to the home/project list while rendering; locate the matching project card by the exact title rather than relying on the current browser URL.
11. Treat a matching card as complete only when its progress overlay is gone and it exposes a completed duration or a visible player/download/share result. Hover that exact completed card to reveal its action bar. The current UI shows a download icon, a share icon, and an overflow (`...`) icon. Click the download icon when it directly starts a file download. If the action bar opens an overflow menu, select **Download Video**; do not select **Download Audio** or **Download Subtitles**. That action opens the matching project's `video_url` with a download-disposition filename derived from the project title. Capture the exact opened URL and return it as the final video download URL. If the browser exposes only the underlying source, return that matching project's `video_url`; it is the media URL used by the export action. Do not wait for a filesystem download event or report a downloaded artifact instead of the URL. If a popup resets the browser binding, reconnect to the same session, locate the completed card by its exact title, and extract the same project's `video_url` or download URL. Never use a media URL from another card, a cover-image URL, or the current browser tab URL. If the completed card exposes no `video_url`, source element, download URL, or copy-media-link control, report that no video link was surfaced.

Never bypass authentication, CAPTCHA, payment, usage limits, or warning dialogs. Do not use a Podcastor API as a substitute for this browser flow.
