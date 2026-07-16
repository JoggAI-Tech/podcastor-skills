# Topic Deep Research

Run this workflow before proposing any topic, whether the topic was discovered by Codex, supplied by the user, or selected from earlier candidates. A user-selected topic still needs research; selection is editorial interest, not factual validation.

## Research Procedure

1. Normalize the topic into a testable editorial question, audience, geography, and time window. Preserve the user's intended subject; narrow the angle only when the evidence requires it.
2. Research the question with Firecrawl. For a current, factual, or contentious topic, search and scrape at least three relevant sources, including a primary or official source when one exists and at least two independent sources. Save results under `.firecrawl/topic-research/<topic-slug>/`; read existing results before issuing new searches.
3. Separate verified facts, credible interpretations, counterarguments, and unresolved questions. Record publication dates and conflicts. Do not treat a headline, press release, or a single source as sufficient support for a contested claim.
4. For a private user source, analyze the supplied material locally. Research only non-sensitive, high-level concepts externally; never send the source text, local attachment contents, or personal data to Firecrawl.
5. If evidence is thin, stale, inaccessible, or contradictory, say so. Recommend a narrower question, a qualified explainer, or a different candidate. Never fill a research gap with invented data, quotations, people, companies, or events.

## Topic Score

Score each candidate from 0 to 5 on each dimension, then report the total out of 40:

| Dimension | What a high score means |
| --- | --- |
| Audience relevance | Directly answers a meaningful listener need or curiosity |
| Evidence quality | Multiple credible, current, and appropriately primary sources support the premise |
| Freshness | Timely event, change, or durable question with a clear current reason to listen |
| Editorial tension | Has real tradeoffs, mechanisms, or competing interpretations rather than a single obvious claim |
| Narrative or discussion potential | Supports a hook, progression, examples, and a satisfying close |
| Distinctiveness | Offers a specific angle instead of a generic recap or trend label |
| Duration fit | Has enough verified material for the selected Podcastor band without padding or rushing |
| Production fit | Has a credible match to a Podcastor presentation form and host dynamic |

Recommend candidates at 26 or above only when evidence quality is at least 3. If the user insists on a lower-scoring topic, keep the score and constraints visible, narrow the claim, and avoid overstating certainty.

## Multi-Angle Analysis

For each recommended candidate, analyze at least these lenses when applicable:

- What changed and why it matters now.
- Mechanism, incentives, and practical consequence.
- Beneficiaries, costs, risks, and credible counterarguments.
- What listeners should watch next and what remains uncertain.

Keep the analysis factual. A sensitive topic may need a restrained explainer rather than a debate or playful presentation.

## Production Plan

Include this concise plan in the topic-and-style proposal before requesting confirmation:

| Field | Required plan |
| --- | --- |
| Title and hook | Specific title plus the opening question or tension |
| Audience and payoff | Who it serves and what they will understand or decide differently |
| Editorial angle | The strongest research-backed angle, not a source recap |
| Content pillars | Three ordered beats drawn from the multi-angle analysis |
| Script style | Adaptive, storytelling, debate, or custom style, with a reason |
| Hosts | One or two, with distinct roles when two are used |
| Duration | Podcastor band and approximate Chinese-character or English-word target from `duration-bands.md` |
| Presentation | Primary form, camera treatment, and at most one alternative from the Studio matrix |
| Evidence limits | Material uncertainty, source gaps, and claims to qualify or omit |

The proposal must make the dependencies coherent: the title must fit the angle, the content pillars must fit the duration, the script style must match the evidence and tension, and the Studio form must fit the audience and host roles. Ask the user to confirm or adjust this complete plan before writing the script.
