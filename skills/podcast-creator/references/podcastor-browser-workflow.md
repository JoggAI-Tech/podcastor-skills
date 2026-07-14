# Podcastor Browser Workflow

Use this workflow only after the user has approved the current one- or two-host script and explicitly asks to send it to Podcastor.

1. Open `https://podcastor.ai/video-podcast` with the in-app browser and inspect the current page rather than assuming labels or controls.
2. Verify the script has a title and only `A:` or `B:` spoken lines. Use the site's upload-script or manual-script path to populate it. Preserve the exact approved wording.
3. If the site requires sign-in, explain that the user must complete login, registration, verification, CAPTCHA, and any credential entry themselves. Resume only after they say it is complete.
4. Map `A` to Host 1 and, for a two-host script, `B` to Host 2. Let the user select voices and existing avatars. If they ask to create a new avatar, show the available method and any visible cost, then ask for confirmation before submitting creation.
5. Before a Generate Audio or Render Audio action, show the selected voices and visible credit estimate. Ask for explicit confirmation before submitting the request. Wait for the page to report success or failure.
6. Let the user select a video layout, aspect ratio, and avatars. Before Render Video, show the selected configuration and visible credit estimate. Ask for explicit confirmation before clicking the render action.
7. Wait for the result state. Report the resulting project or media link when available; otherwise report the surfaced error and keep the current script available for correction.

Never bypass authentication, CAPTCHA, payment, usage limits, or warning dialogs. Do not use a product API as a substitute for this browser flow.
