# Podcastor Duration Bands

Podcastor exposes these production bands in the current Studio UI. Estimates apply to spoken body text only; the title and `A:`/`B:` labels add negligible length.

| Podcastor band | Chinese estimate | English estimate | Best use |
| --- | ---: | ---: | --- |
| `~5min` | 1,250-1,750 characters | 600-800 words | Short explainer, single story turn, compact debate |
| `7~12min` | 1,750-4,200 characters | 840-1,920 words | Standard analysis, case, or two-host discussion |
| `13~17min` | 3,250-5,950 characters | 1,560-2,720 words | Deep dive with evidence, mechanisms, and rebuttals |
| `18~22min` | 4,500-7,700 characters | 2,160-3,520 words | Long-form episode with multiple layers and examples |
| `23~30min` | 5,750-10,500 characters | 2,760-4,800 words | Feature episode, full debate, or extensive narrative |

These ranges use approximately 250-350 Chinese characters or 120-160 English words per spoken minute. Actual render time varies with pauses, pronunciation, numbers, acronyms, and voice settings; allow roughly 10-15% variance and do not pad with repetition.

## Selection Rules

- For Podcastor production, map a requested duration to the nearest visible band and report the mapping. A request for 3-6 minutes maps to `~5min`; do not claim that the UI supports an exact 3-minute render.
- A local-only script may honor an exact duration outside these bands.
- If a request exceeds 30 minutes, split it into episodes or keep it local rather than inventing an unsupported Podcastor band.
- Select the band before final validation, then check the spoken body count against the corresponding language estimate.
