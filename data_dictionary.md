# Data Dictionary

This file documents every variable used from each of the three source datasets, the transformations applied to it, and why. It is meant to stand on its own — a reader should be able to trust a downstream number in `reports/` back to exactly what raw field it came from and what cleaning decision touched it.

Conventions used throughout:
- **Source variable** — the exact field name as it appears in the original codebook/file.
- **Type (raw → cleaned)** — encoding before and after cleaning.
- **Missingness (raw)** — how missingness manifests in the *source* file (explicit null vs. implicit sentinel/empty string).
- **Disposition** — what this project did with the field: kept as-is, recoded, or dropped, and why.

---

## Dataset: SHED 2020 Public-Use Microdata

- **Source**: Board of Governors of the Federal Reserve System
- **Codebook**: [SHED_2020codebook.pdf](https://www.federalreserve.gov/consumerscommunities/files/SHED_2020codebook.pdf)
- **Raw file**: `public2020.sas7bdat` → converted to `shed2020.csv`
- **Starting shape**: 11,648 respondents × 372 columns; subset to the fields below for analysis
- **Missing-value convention**: numeric fields coded `0`/`1`, with `-1` denoting refusal-to-respond and `NaN` denoting true missing; some fields stored inconsistently as `0.`/`1.` rather than clean integers
- **Rows removed during cleaning**: 137 (see disposition notes below)
- **Cleaned output**: `shed20_cleaned2.csv`

| Source variable | Label | Type (raw → cleaned) | Missingness (raw) | Disposition |
|---|---|---|---|---|
| `C2A` | Credit card ownership (0/1) | float → `Int64` | None identified | Kept; standardized to `Int64`. Cross-checked against `C4A` for logical consistency (no unpaid-balance behavior reported by non-owners) — no contradictions found. |
| `C4A` | Frequency of carrying an unpaid credit card balance | `0/1/2/3/-1/NaN` → `Int64` with sentinel `-2` | ~13.8% `NaN` (true missing) | `NaN` values filled with sentinel `-2` (distinct from valid responses `0`–`3` and from refusal `-1`) rather than dropped. Rows where `C4A` (or any other analysis field) equaled `-1` (refused) were dropped in the refusal-removal step below. Final valid value set: `{-2, 0, 1, 2, 3}`. |
| `EF1` | Has emergency savings (0/1) | float → `Int64` | None identified | Kept; standardized to `Int64`. Used as cross-check against `EF3` series — no contradictions found. |
| `EF2` | Ability to cover 3 months if income is lost (0/1) | float → *dropped* | — | **Dropped**, for consistency with the 2024 wave (see below) and to keep both years directly comparable on the remaining variables. |
| `EF3_A`–`EF3_H` | Emergency $400-expense payment method, multi-select (see labels in the 2024 table below — same definitions apply) | float → `Int64` | None identified | Kept; each sub-item standardized to `Int64` individually. |

**Row-level exclusions applied to this dataset**: rows containing `-1` (refusal) in any of the selected binary/`C4A` fields were dropped via `df_shed20 = df_shed20[~df_shed20.eq(-1).any(axis=1)]`. **Total: 137 rows dropped.**

**Syntactic correction applied**: binary columns (`C2A`, `EF1`, `EF3_A`–`EF3_H`) and `C4A` were initially stored as floats (e.g., `1.0`, `0.0`), which broke downstream string/integer comparisons; all were cast to `Int64` with validated value sets (`{0, 1}` for binaries, `{-2, 0, 1, 2, 3}` for `C4A`).

---

## Dataset: SHED 2024 Public-Use Microdata

- **Source**: Board of Governors of the Federal Reserve System
- **Codebook**: [SHED_2024codebook.pdf](https://www.federalreserve.gov/consumerscommunities/files/SHED_2024codebook.pdf)
- **Raw file**: `shed2024.sas7bdat`
- **Starting shape**: 12,295 respondents × 753 columns; subset to the fields below for analysis
- **Missing-value convention**: empty string (`""`) for non-response — an *implicit* missingness pattern, since `df.isna().sum()` reports these fields as having negligible explicit `NaN`s
- **Rows removed during cleaning**: 3; `EF2` dropped as a feature entirely
- **Cleaned output**: `shed24_cleaned2.csv`

| Source variable | Label | Type (raw → cleaned) | Missingness (raw) | Disposition |
|---|---|---|---|---|
| `C2A` | Credit card ownership (Yes/No) | string → `Int64` | None (explicit) | Kept; cross-checked against `C4A` for logical consistency after the `C4A` recoding step below — no contradictions found. |
| `C4A` | Frequency of carrying an unpaid credit card balance | string → categorical | Empty string (`""`) for a meaningful share of records | Blank `C4A` values were cross-checked against `C2A` and found to correspond entirely to respondents who do not own a credit card. **Recoded** (not dropped) to a new category, `"No credit card ownership"`. Final allowed categories: `"Never carried an unpaid balance (always pay in full)"`, `"Once"`, `"Some of the time"`, `"Most or all of the time"`, `"No credit card ownership"`. |
| `EF1` | Has emergency savings (Yes/No) | string → `Int64` | None (explicit) | Kept. |
| `EF2` | Ability to cover 3 months of expenses if income is lost | string → *dropped* | >50% empty string (implicit) | **Dropped entirely** from both 2024 and 2020. Implicit missingness exceeded 50%, making the field unrepresentative; imputing at this rate would manufacture signal rather than recover it. |
| `EF3_a`–`EF3_h` | Emergency $400-expense payment method, multi-select: `a` pay credit card in full next statement, `b` pay credit card over time, `c` pay from checking/savings/cash, `d` bank loan/line of credit, `e` borrow from friend/family, `f` payday loan/deposit advance/overdraft, `g` sell something, `h` would not be able to pay | string → `Int64` per sub-item | None (explicit) | Kept; each sub-item standardized to `Int64` individually. |

**Row-level exclusions applied to this dataset**: semantic-contradiction check between `EF2` and the `EF3` series — rows where `EF2 == "Yes"` (can cover 3 months) but *all* of `EF3_a`–`EF3_h` were `"No"` (no way to pay a $400 emergency) were flagged as logically impossible and dropped. **Total: 3 rows dropped.**

**Cross-year note**: 2020 and 2024 use different missing-value conventions (`-1`/`NaN` sentinel-and-null split vs. implicit empty-string) and different raw storage (numeric float vs. string categorical). Both years were converted to a common `Int64`/categorical representation before any cross-year comparison, and `EF2` was dropped from *both* waves to keep the compared feature set identical across years.

---

## Dataset: CFPB Consumer Credit Trends — Credit Card Borrower Risk Profiles (Lending Levels)

- **Source**: Consumer Financial Protection Bureau
- **Raw file**: `volume_data_Score_Level_CRC.csv` → cleaned as `cfpd_cleaned2.csv`
- **Rows**: 1,100 | **Columns**: 5
- **Panel range**: January 2007 through at least April 2025 (this project uses only the 2020 and 2024 annual aggregates)
- **Rows removed during cleaning**: 0 — dataset required interpretation, not remediation
- **Provenance caveat**: underlying credit records are drawn from a sample tied to a single nationwide consumer reporting agency (NCRA); CFPB notes that shifts in market share across bureaus cannot be fully controlled for in this series

| Source variable | Label | Type | Range / allowed values | Missingness | Disposition |
|---|---|---|---|---|---|
| `month` | Months since observation start (Jan 2007 = 0) | Integer | 0 – ongoing | None | Kept as-is; used for temporal alignment to SHED reference years. |
| `date` | Observation date | String, `YYYY-MM` | 2007-01 – present | None | Kept as-is; validated as consistently formatted via value-count inspection. |
| `vol` | Seasonally adjusted total dollar volume of new credit card limits | Float | Non-negative | None | Kept as-is; validated non-negative and consistent in magnitude with `vol_unadj`. |
| `vol_unadj` | Unadjusted (raw) total dollar volume of new credit cards opened that month | Float | Non-negative | None | Kept as-is; validated non-negative. |
| `credit_score_group` | Borrower risk tier | Categorical | `Deep subprime` (<580), `Subprime` (580–619), `Near-prime` (620–659), `Prime` (660–719), `Super-prime` (720+) | None | Kept as-is; validated exactly five categories present with no unexpected labels, and a full set of tiers present for spot-checked months. |

**Restriction and aggregation applied for this project**: restricted to credit-card-only records; monthly volumes summed to annual totals per `credit_score_group` for 2020 and 2024; a `log_vol` transform applied to `vol`/`vol_unadj` totals for interpretable-scale comparison across tiers of very different magnitude.

**Provenance note**: this dataset is a genuine panel (month × risk-tier), not individual survey responses, so it cannot be joined row-for-row with SHED. It is linked at the credit-score-tier level via the derived `proxy_credit_group` described below, aggregated to the SHED reference years (2020, 2024).

---

## Derived / Analysis-Ready Fields

These are the key bridge variables that make SHED and CFPB comparable, since neither source shares a respondent ID or a native credit-score field on the SHED side.

### `risk_score` (SHED 2020 and 2024)

An intermediate numeric financial-vulnerability score, built independently in each wave from that wave's native encoding, then mapped to a common category (below). Not used directly in the final interpretation — it exists purely to derive `proxy_credit_group`.

**Construction (2024, string-coded fields)** — start at 0, add 1 point for each of:
- `EF1 == "No"` (no emergency savings)
- `EF3_b == "Yes"` (would pay emergency via credit card over time)
- `EF3_e == "Yes"` (would borrow from friend/family)
- `EF3_d == "Yes"` (would use bank loan/line of credit)
- `C2A == "No"` (no credit card access)
- `C4A` frequency: `"Once"` → +1, `"Some of the time"` → +2, `"Most or all of the time"` → +3

**Construction (2020, numeric-coded fields)** — identical logic, adapted to 0/1 coding:
- `EF1 == 0`, `EF3_B == 1`, `EF3_E == 1`, `EF3_D == 1`, `C2A == 0` each add 1 point
- `C4A == 1/2/3` adds 1/2/3 points respectively

*(Note: `EF2` was dropped from both waves before this stage, so it does not contribute to `risk_score` despite being a financial-resilience-relevant field — see the completeness notes above.)*

### `proxy_credit_group` (SHED 2020 and 2024)

Categorical mapping of `risk_score` into the same five tiers CFPB uses natively, enabling the SHED–CFPB merge:

| `risk_score` range | `proxy_credit_group` |
|---|---|
| 0–1 | Super-prime |
| 2–3 | Prime |
| 4–5 | Near-prime |
| 6–7 | Subprime |
| ~8 | Deep subprime |

**Source fields**: `EF1`, `C2A`, `C4A`, `EF3_b`/`EF3_B`, `EF3_d`/`EF3_D`, `EF3_e`/`EF3_E` (post-cleaning versions).

**Notes**: this is a *proxy* — SHED respondents do not report an actual credit score, so `proxy_credit_group` approximates risk tier from self-reported financial behavior rather than from bureau data. This is the single most important modeling assumption in the project: all SHED–CFPB comparisons inherit whatever error exists in this proxy construction. Worth stating explicitly in any external-facing summary of the findings.

### `log_vol` (CFPB, merge-ready)

Natural-log transform of annually aggregated `vol` (and `vol_unadj`) per `credit_score_group`, used to make cross-tier volume comparisons visually and statistically interpretable given the multiple-orders-of-magnitude spread between Deep Subprime and Super-prime origination volumes.

**Source fields**: `vol`, `vol_unadj` (post-annual-aggregation).
