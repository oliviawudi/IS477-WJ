# Financial Literacy and Household Credit Card Debt Before and After COVID-19

## Contributors

- **Wenqi Shan** 
- **Jun Kim**

## Summary

The COVID-19 pandemic reshaped household finances in ways that are still unfolding. This project asks a narrow, testable version of that broad question: **did the relationship between financial literacy and household credit card debt change between 2020 and 2024, and did more financially literate households see smaller increases in debt?**

We answer this by integrating three federal and public data sources into a single reproducible pipeline. Two are individual-level survey waves — the Federal Reserve's *Survey of Household Economics and Decisionmaking* (SHED) for 2020 and 2024 — and the third is a macro-level series from the Consumer Financial Protection Bureau (CFPB) tracking national credit card origination volume by borrower risk tier. The SHED waves let us compare self-reported financial literacy proxies (emergency savings, emergency-expense payment behavior) against self-reported credit card repayment behavior at the household level, cross-sectionally in each year. The CFPB series lets us contextualize those household-level patterns against what was actually happening in the national credit market at the same time — did the volume and risk composition of new credit card originations shift in ways consistent with the survey findings?

Because SHED changes its microdata encoding, variable completeness, and (in some years) its exact question wording from wave to wave, most of the analytical effort in this project went into **data profiling and cleaning** rather than modeling: reconciling two different missing-value conventions (empty string vs. `-1` sentinel), checking for logical contradictions between related survey items (e.g., a respondent who says they *could* cover an emergency but not *how* they would), and standardizing types across years before any comparison could be trusted. That cleaning process — and the documentation of every decision made during it — is the core deliverable of this repository, not just the downstream statistics.

**Research Questions**

1. Did the strength of the relationship between financial literacy and household credit card debt change after the COVID-19 pandemic?
2. Did households with higher financial literacy show smaller increases in debt post-COVID-19?

## Data Profile

Full variable-level metadata (definitions, types, allowed values, missingness, and provenance for every field used in this analysis) lives in [`docs/data_dictionary.md`](docs/data_dictionary.md). The summary below covers dataset-level identification, access, and licensing — the metadata a data catalog would need to index this project.

### Dataset 1 — SHED 2020 Public-Use Microdata

| Field | Value |
|---|---|
| **Title** | Survey of Household Economics and Decisionmaking (SHED), 2020 Public-Use Microdata |
| **Publisher** | Board of Governors of the Federal Reserve System |
| **Landing page** | <https://www.federalreserve.gov/consumerscommunities/shed_data.htm> |
| **Direct download** | [SHED 2020 SAS ZIP](https://www.federalreserve.gov/consumerscommunities/files/SHED_public_use_data_2020_(SAS).zip) |
| **Documentation / codebook** | [2020 SHED codebook (PDF)](https://www.federalreserve.gov/consumerscommunities/files/SHED_2020codebook.pdf) |
| **Format (as delivered)** | SAS transport file (`publicxxxx.sas7bdat`) |
| **Format (as used in this project)** | CSV, converted via `pandas`/`pyreadstat` |
| **Temporal coverage** | Fielded 2020 (reference period: household finances in 2020) |
| **Spatial coverage** | United States, national sample |
| **Unit of observation** | Individual/household respondent |
| **License / terms of use** | U.S. federal public-use microdata; free to use, but the Federal Reserve requires proper citation, prohibits implying endorsement, and disallows altering variable meaning in a misleading way |
| **Access constraints** | None (public download); no PII in public-use file |
| **Retrieval method in this project** | Direct HTTPS download → SAS-to-CSV conversion in `notebooks/IS_477_Data_Cleaning.ipynb` |

### Dataset 2 — SHED 2024 Public-Use Microdata

| Field | Value |
|---|---|
| **Title** | Survey of Household Economics and Decisionmaking (SHED), 2024 Public-Use Microdata |
| **Publisher** | Board of Governors of the Federal Reserve System |
| **Landing page** | <https://www.federalreserve.gov/consumerscommunities/shed_data.htm> |
| **Direct download** | [SHED 2024 SAS ZIP](https://www.federalreserve.gov/consumerscommunities/files/SHED_public_use_data_2024_(SAS).zip) |
| **Documentation / codebook** | [2024 SHED codebook (PDF)](https://www.federalreserve.gov/consumerscommunities/files/SHED_2024codebook.pdf) |
| **Format (as delivered)** | SAS transport file (`publicxxxx.sas7bdat`) |
| **Format (as used in this project)** | CSV, converted via `pandas`/`pyreadstat` |
| **Temporal coverage** | Fielded 2024 (reference period: household finances in 2024) |
| **Spatial coverage** | United States, national sample |
| **Unit of observation** | Individual/household respondent |
| **License / terms of use** | Same terms as the 2020 wave (see above) |
| **Access constraints** | None (public download); no PII in public-use file |
| **Retrieval method in this project** | Direct HTTPS download → SAS-to-CSV conversion in `notebooks/IS_477_Data_Cleaning.ipynb` |

### Dataset 3 — CFPB Consumer Credit Trends: Credit Card Borrower Risk Profiles (Lending Levels)

| Field | Value |
|---|---|
| **Title** | Consumer Credit Trends — Credit Cards: Borrower Risk Profiles, Lending Levels |
| **Publisher** | Consumer Financial Protection Bureau |
| **Landing page** | <https://www.consumerfinance.gov/data-research/consumer-credit-trends/credit-cards/borrower-risk-profiles/#anchor_lending-levels> |
| **Direct download** | [`volume_data_Score_Level_CRC.csv`](https://files.consumerfinance.gov/data/consumer-credit-trends/credit-cards/volume_data_Score_Level_CRC.csv) |
| **Format** | CSV |
| **Temporal coverage** | Monthly series, January 2007 through at least April 2025, continuously updated |
| **Spatial coverage** | United States, national aggregate |
| **Unit of observation** | Month × credit-score-tier aggregate (not individual-level) |
| **License / terms of use** | Made available under an open public license; use must follow CFPB terms of use and attribution requirements |
| **Access constraints** | None (public download); dataset contains only aggregated statistics, no personal information |
| **Retrieval method in this project** | Direct HTTPS download, saved as raw CSV for aggregation to the SHED reference years |

### Why three sources, and how they connect

SHED gives self-reported, individual-level financial literacy and credit behavior — but only as two disconnected snapshots (2020, 2024), with no way to see the market context around each snapshot. CFPB gives the market context (how much credit was actually being extended, and to which risk tiers) but no individual-level literacy signal. Integrating them lets the analysis distinguish "households changed their behavior" from "the credit market itself changed what was available to them" — a distinction neither source can make alone.

Two harmonization notes worth flagging for anyone reusing this pipeline:

- **Sample-size alignment**: the 2024 SHED wave (~12,300 respondents) is larger than the 2020 wave (~11,600). To keep year-over-year comparisons from being dominated by unequal sample size, a random subsample of 2024 respondents was drawn to match the 2020 sample size before cross-year comparison.
- **CFPB provenance caveat**: CFPB's underlying credit records are drawn from a sample tied to a single nationwide consumer reporting agency (NCRA). CFPB itself notes that shifts in market share across credit bureaus cannot be fully controlled for in this series — worth keeping in mind when interpreting the merged SHED–CFPB comparisons.
- **SHED–CFPB linkage**: since SHED and CFPB have no shared respondent ID (one is survey microdata, the other is an aggregate panel), the two are linked through a derived proxy credit-score tier constructed from SHED responses (see `docs/data_dictionary.md` for the full construction logic) and matched to CFPB's `credit_score_group` categories.

### Ethical and Legal Constraints

- **CFPB data**: available under an open public license; usage must follow CFPB's terms of use and attribution requirements.
- **SHED microdata**: federal public-use files. The Federal Reserve requires proper citation, prohibits implying endorsement, and disallows altering variable meaning in a misleading way. We cite both federal agencies explicitly in this README and in `docs/data_dictionary.md`, and we preserve all original SHED variable labels, documenting every transformation applied.
- **Privacy**: all three sources are public-use, de-identified, and/or aggregate data. No PII is present in or generated by this project.

### FAIR Assessment

| Principle | How this project satisfies it |
|---|---|
| **Findable** | Public GitHub repository with a documented directory structure, a dataset-level table (above) and a variable-level data dictionary (`docs/data_dictionary.md`); large files indexed via a public Box folder link. |
| **Accessible** | Public GitHub repo; Box folder with access verified for UofI accounts; all three source datasets are freely downloadable without registration. |
| **Interoperable** | Open formats (CSV, Markdown, Jupyter), standard Python libraries (`pandas`, `pyreadstat`, `scikit-learn`), and a Snakemake workflow specifying step dependencies explicitly. |
| **Reusable** | MIT-licensed code, CC-BY-4.0 documentation, explicit step-by-step reproduction instructions (below), and a variable-level codebook mapping every derived feature back to its source variable. |

## Data Quality

Quality assessment followed the same three-part lens (completeness, semantic accuracy, syntactic accuracy) across all three sources. Full remediation logic, exact row counts, and the derived `risk_score`/`proxy_credit_group` construction are documented per-dataset in `docs/data_dictionary.md`; summarized here:

### SHED 2024

- **Starting shape**: 12,295 respondents × 753 columns, subset to the literacy/credit-relevant fields (`C2A`, `C4A`, `EF1`, `EF2`, `EF3_a`–`EF3_h`).
- **Completeness**: `EF2` was empty-string in over 50% of records and was dropped as a feature rather than imputed, to avoid manufacturing signal from a mostly-absent variable. `C4A` blanks were cross-checked against `C2A` and found to correspond entirely to non-cardholders — rather than dropping these rows, they were **recoded** to a new valid category, `"No credit card ownership"`, preserving them as informative rather than missing.
- **Semantic accuracy**: Cross-checked `EF2` against the `EF3` emergency-payment series for logical contradiction (answering "yes, I have 3 months of coverage" while also answering "I wouldn't be able to pay for the expense"). Found and removed 3 contradictory rows. Checked `C2A` against `C4A` for the impossible case of repayment behavior reported by a non-cardholder — found none after the recoding step above.
- **Syntactic accuracy**: Binary survey fields validated as consistently yes/no coded.
- **Net effect**: 3 rows removed for semantic contradiction; `EF2` dropped as a feature; `C4A` blanks recoded rather than dropped.

### SHED 2020

- **Starting shape**: 11,648 respondents × 372 columns, subset to the same field set (numerically coded in this wave: `C2A`, `C4A`, `EF1`, `EF2`, `EF3_A`–`EF3_H`).
- **Completeness**: 2020 uses a different missing-value convention than 2024 — binary fields coded `0`/`1`, with `-1` denoting refusal, and true missing values appearing as `NaN`. `C4A` had ~13.8% `NaN` (true missing); these were filled with a distinct sentinel value (`-2`) rather than dropped, keeping them distinguishable from both valid responses and refusals. Rows with `-1` (refusal) in *any* of the analysis fields were dropped entirely. `EF2` was dropped as a feature in this wave too, for consistency with 2024 and to keep both years directly comparable on the remaining variables.
- **Semantic accuracy**: `EF1` cross-checked against the `EF3` series, and `C2A` against `C4A` — no contradictions found.
- **Syntactic accuracy**: Several fields were stored as `0.`/`1.` rather than proper integer types; all binary fields plus `C4A` were cast to `Int64` to standardize against 2024 before cross-year comparison.
- **Net effect**: 137 rows dropped (refusal removal across analysis fields); `EF2` dropped as a feature; `C4A` `NaN`s recoded to sentinel `-2` rather than dropped.

### CFPB Lending Levels

- **Completeness**: No explicit or implicit missing values across all 1,100 rows × 5 columns.
- **Semantic accuracy**: `vol`/`vol_unadj` contain no negative values and are consistent in magnitude with one another; all five `credit_score_group` categories (Deep subprime, Subprime, Near-prime, Prime, Super-prime) appear exactly once per month, confirming a consistent panel structure.
- **Syntactic accuracy**: Numeric types and date formats validated as consistent throughout.
- **Net effect**: No rows dropped — this dataset required interpretation, not cleaning.

## Findings

**RQ1 — Did the strength of the relationship between financial literacy and household credit card debt change after COVID-19? No.**

Within SHED alone, every literacy and credit-behavior indicator we tracked was remarkably stable across the two waves: `EF1` (has emergency savings) sits at essentially 50/50 in both 2020 and 2024, "good" emergency-response behaviors (`EF3_A`, `EF3_C`) and "stressed" behaviors (`EF3_B/D/E/F/G/H`) moved by only 1–3 percentage points, and credit card ownership (`C2A`) plus unpaid-balance behavior (`C4A`) shifted by about 1 percentage point. None of this looks like a pandemic-driven structural change — it reads as stability, or noise around a stable baseline.

Once SHED is merged with CFPB by credit-score tier, the *relationship* between literacy and credit access is where the real signal is — and it held constant across years. In both 2020 and 2024, credit-score groups with higher `EF1` and more "good" `EF3` behavior (Prime, Super-prime) received substantially larger credit card origination volumes than Deep Subprime/Subprime groups, who simultaneously showed the weakest literacy indicators and the highest financial-stress indicators (`C4A`, `EF3_B`, `EF3_D`). That literacy-to-access gradient is qualitatively the same shape in both years — it didn't compress, widen, or flip.

**RQ2 — Did households with higher financial literacy show smaller increases in debt post-COVID? No — the opposite.**

Using CFPB credit volume as a proxy for new credit card debt issuance, every credit-score tier saw higher origination volume in 2024 than in 2020 — but the *largest* increases were concentrated in Prime and Super-prime tiers, the groups with the strongest emergency-savings rates and lowest financial-stress indicators. Deep Subprime and Subprime groups grew too, just by a smaller margin. So post-COVID credit expansion disproportionately flowed to already financially-resilient households rather than to the groups showing more financial stress — the inverse of what the "smaller increases for literate households" hypothesis predicted.

**Headline takeaway:** the pandemic didn't reshape the relationship between financial literacy and credit card debt — it reinforced the pre-existing gradient. Households with stronger financial-resilience indicators kept getting more credit access and larger credit growth after COVID, while financially stressed households saw smaller gains on both fronts. Household resilience proved sticky; credit-market conditions didn't level the playing field.

## Reproducing This Analysis

Full step-by-step commands are in [`docs/Reproduce.md`](docs/Reproduce.md). At a high level:

1. **Clone the repo and set up the environment**
   ```bash
   git clone https://github.com/oliviawudi/IS477-WJ.git
   cd IS477-WJ
   python3 -m venv venv && source venv/bin/activate
   pip install -r requirements.txt
   ```
2. **Get the data.** SHED 2020/2024 and the CFPB CSV are fetched by the pipeline directly from the URLs in the Data Profile table above; alternatively, pull the already-processed outputs from the [Box folder](https://uofi.box.com/s/ietmow5zmh9ewrgu13qb431de4x3euce).
3. **Run the Snakemake workflow** to execute cleaning → integration → analysis end to end:
   ```bash
   snakemake --cores 1
   ```
4. **Inspect outputs** — cleaned CSVs, the merged analysis table, and generated figures/tables land in `reports/` and `data/processed/`; see `docs/Reproduce.md` for exact filenames.

Software environment is pinned in `requirements.txt`, with a `pip freeze` snapshot for exact reproducibility; see `docs/Reproduce.md` for Python version and OS details used during development.

### Workflow DAG

The Snakemake workflow encodes the full lineage from raw SHED/CFPB files to final merged analysis, as a directed acyclic graph:

```
clean_shed ──► shed24_match_shed20 ──┬──► aggregate_sheds ──────────────┐
                                       └──► shed_credit ──► shed_credit_concat ──► shed_group ──┐
                                                                                                  ├──► merge ──► merge_analysis ──┐
clean_cfpb ──► cfpb_group ──► cfpb_analysis ────────────────────────────────────────────────────┘                              ├──► run_all
                                                                                    aggregate_sheds ──► shed_analysis ───────────┘
```

| Rule | Input | Output | Purpose |
|---|---|---|---|
| `clean_shed` | `shed2024.sas7bdat`, `public2020.sas7bdat` | `shed24_cleaned2.csv`, `shed20_cleaned2.csv` | Missing-value handling, type normalization, recoding (see Data Quality above) |
| `clean_cfpb` | `volume_data_Score_Level_CRC.csv` | `cfpd_cleaned2.csv` | CFPB validation/cleaning |
| `shed24_match_shed20` | `shed24_cleaned2.csv` | `df_shed24ver1.csv` | Subsamples 2024 to match 2020 sample size |
| `aggregate_sheds` | `df_shed24ver1.csv`, `shed20_cleaned2.csv` | `df_shed.csv` | Concatenates harmonized SHED years |
| `shed_credit` / `shed_credit_concat` | `df_shed24ver1.csv`, `shed20_cleaned2.csv` | `shed2.csv` | Filters both years to credit-card owners, concatenates |
| `shed_group` | `shed2.csv` | `shed_year.csv` | Groups by `proxy_credit_group` × year |
| `cfpb_group` | `cfpd_cleaned2.csv` | `crc_year.csv` | Aggregates by `credit_score_group` × year |
| `cfpb_analysis` | `crc_year.csv` | `analysis_cfpb.PNG` | CFPB-only lending-volume diagnostics |
| `shed_analysis` | `df_shed.csv` | SHED diagnostic PNGs | SHED-only profiling/exploratory plots |
| `merge` | `shed_year.csv`, `crc_year.csv` | `merged.csv` | Aligns individual-level SHED behavior with macro-level CFPB credit environment |
| `merge_analysis` | `merged.csv` | `analysis_merged_1.PNG`, `analysis_merged_2.PNG` | Final figures answering both research questions |
| `run_all` | all analysis outputs | — | Orchestrates the full pipeline end to end |

## Repository Structure

```
IS477-WJ/
├── data/
│   ├── raw/                  # gitignored — fetched via pipeline or Box
│   └── processed/            # gitignored — pipeline outputs
├── docs/
│   ├── data_dictionary.md    # variable-level metadata for all 3 datasets
│   ├── ProjectPlan.md
│   ├── StatusReport.md
│   └── Reproduce.md
├── notebooks/
│   ├── IS_477_Data_Cleaning.ipynb
│   ├── IS_477_Analysis.ipynb
│   └── workflow_and_provenance.ipynb
├── reports/
│   └── Final Project Report.pdf
├── Snakefile
├── requirements.txt
├── CITATION.cff
├── LICENSE
└── README.md
```

## Future Work

- **Geography**: SHED does not offer regional or county-level detail, limiting analysis of geographic disparities. Merging county-level covariates (unemployment, local price indices) would help separate place-based effects from individual literacy effects.
- **CFPB depth**: the current CFPB extract covers only origination volume and risk-tier composition. Adding utilization, repayment, and delinquency series would sharpen the national-context comparison.
- **Literacy measurement**: `EF1`/`EF3` are high-level proxies. Multi-item literacy scales or numeracy batteries would support richer modeling of the literacy → debt pathway.
- **Modeling depth**: current analysis is descriptive/comparative; logistic regression, hierarchical models, or matching methods could quantify group differences while controlling for income, education, and employment shifts.
- **Longitudinal extension**: additional SHED waves (pre-pandemic baseline, intermediate years) would let the project model a trend rather than a two-point comparison.
- **Qualitative complement**: SHED's open-ended fields, where available, could add lived-experience context to the quantitative patterns.

## References

### Data Sources

Federal Reserve Board. (2021). *Survey of Household Economics and Decisionmaking (SHED), 2020 Public-Use Microdata*. Retrieved from <https://www.federalreserve.gov/consumerscommunities/shed_data.htm>

Federal Reserve Board. (2025). *Survey of Household Economics and Decisionmaking (SHED), 2024 Public-Use Microdata*. Retrieved from <https://www.federalreserve.gov/consumerscommunities/shed_data.htm>

Consumer Financial Protection Bureau. (2025). *Consumer Credit Trends: Credit Card Originations and Credit Limits*. Retrieved from <https://www.consumerfinance.gov/data-research/consumer-credit-trends/credit-cards/borrower-risk-profiles/#anchor_lending-levels>

### Software

McKinney, W. (2010). Data structures for statistical computing in Python. In *Proceedings of the 9th Python in Science Conference* (Vol. 445, pp. 51–56).

Pedregosa, F., et al. (2011). Scikit-learn: Machine learning in Python. *Journal of Machine Learning Research*, 12, 2825–2830.

Köster, J., & Rahmann, S. (2012). Snakemake — a scalable bioinformatics workflow engine. *Bioinformatics*, 28(19), 2520–2522. <https://snakemake.readthedocs.io/>

### Project Citation

For citation of this project, see [`CITATION.cff`](CITATION.cff), or:

```
Shan, W., & Kim, J. (2026). Financial Literacy and Household Credit Card Debt
Before and After COVID-19 [Software]. GitHub. https://github.com/oliviawudi/IS477-WJ
```

## Licenses

- **Code**: MIT License — see [`LICENSE`](LICENSE).
- **Data**: SHED microdata are U.S. federal public-use files (attribution required, no implied endorsement, no misleading alteration of variable meaning); CFPB data is available under an open public license with attribution required. Neither source's terms permit relicensing the raw data itself — this repository redistributes only derived/cleaned outputs alongside citations back to the originals.
- **Documentation**: This README and accompanying `docs/` files are licensed under CC-BY-4.0.
