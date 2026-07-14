# Custom Style

Transfer abstract, user-approved style qualities to a new episode without copying recognizable language or impersonating a person.

## Build A Style Profile

Analyze the reference for program shape, host roles, opening, structure, pace, sentence length, tone, information density, transitions, humor level, and closing. Present an editable abstract profile before writing the episode when the user asks to define a style.

Do not preserve or reproduce distinctive phrases, catchphrases, host identities, private persona, branded framing, or long passages. A reference script is not evidence for new factual claims unless the user explicitly supplies it as content source too.

Read [the profile format](style-profile-format.md) when creating, revising, or saving a profile.

## Generate The Episode

Collect the new content source first, then missing language, one- or two-host count, duration, and audience. Default to simplified Chinese, two hosts, and three minutes. Use `A` only for a solo episode, otherwise use `A` and `B`.

Keep the transferable rhythm and structure while making all wording, examples, and host roles appropriate to the new topic. Favor factual clarity and natural listening over stylistic similarity when they conflict.

## Saving

Save a named Markdown profile only after the user explicitly says to save it and confirms its name. Write it to `podcast-style-profiles/<profile-name>.md` in the current workspace. If the user asks for another location, require a workspace-relative path; do not write user profiles into the installed skill directory or outside the current workspace. Do not save the reference transcript or copied wording with the profile.
