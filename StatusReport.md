# Updates 
## 1. Project Pan (Based on Feedback)
To address feedback encouraging integration of our data from multiple sources, we expanded our project by adding an external dataset from the Consumer Financial Protection Bureau (CFPB). Unlike the Federal Reserve’s SHED data, which mostly captures household-level experiences and perceptions, the CFPB dataset would provide macro-level indicators, including things like monthly trends in credit card originations, inquiries, and borrowing activity. We decided to acquire those data by SAS file on SHED dataset of the year 2024 and 2020, and CSV file on CFPB data.

The CFPB of Consumer Credit Trends dataset provides monthly, nationwide information on new credit card originations. It includes the total dollar volume of new credit card limits issued to different credit score groups, ranging from deep subprime to super-prime borrowers. The dataset contains both seasonally adjusted and unadjusted lending volumes, allowing analysis of raw lending activity as well as smoothed long-term trends from the year 2007 Jan to 2025 Apr. Each row represents one credit score category for a given month. This dataset helps us understand how lending patterns differ across borrower risk levels.

This new dataset will allow us to enrich SHED respondents’ financial experiences with contextual information about the broader credit environment. Adding the CFPB dataset introduces some challenges in the data integration process, which strengthens the methodological rigor of our project. 

We also deleted the third research question of 
## 2. Timeline
Week5 (Nov/17 ~ 23)
Jun : Workflow automation and provenance

Wenqi: Reproducibility & Transparency

Week6 (Nov/24 ~ 30)
Jun : Metadata and data documentation

Wenqi: Reproducibility & Transparency

Week7 (Nov/31 ~ Dec/7)
Release to GitHub of completed project





## 3. Contributions Task

Jun	


## Wenqi
## Ethical Data Handling
We will identify all ethical, legal, or policy constraints and how they were addressed. This project will integrate multiple datasets, including the Federal Reserve's SHED data (2020 & 2024) and the external credit volume indicator from the Consumer Financial Protection Bureau. Because these data contain sensitive consumer socioeconomic information, our data handling process would be guided by Consent, Privacy, Confidentiality, Copyright, and Terms of Use. 
1.	Consent & Human Subject Consideration
o	Even though SHED's datasets are publicly released, respondents provided data for government analysis
o	Therefore, we followed the Federal Reserve's documentation, which confirms that informed consent was obtained by the original data collectors and that all SHED public-use data are anonymized and non-identifiable before release.
2.	Privacy & Confidentiality
o	SHED includes detailed information, including a huge amount of features such as household financial stress, credit access, loan denials, and income changes.
o	Integrating multiple datasets can theoretically increase the risk of re-identification if merges occur at too granular a level.
o	Therefore, we will perform merges on the year level instead of individual respondents. And no personal identifiers were created, matched, or inferred.
3.	Copyright, Licensing, Terms of Use
o	CFPB makes Consumer Credit Trends available under an open public license, but use must follow the terms of use and attribution requirements.
o	SHED microdata are federal public-use files, but FRB requires proper citation, prohibits implying endorsement, and disallows altering variable meaning in a misleading way.
o	Therefore, we will cite both federal agencies explicitly in the report and codebook and preserve all original SHED variable labels and carefully documented transformations.
Storage & Organization
All documents are stored in a box folder.

## Extraction & Enrichment
1.	We extracted two waves of publicly accessible SHED microdata
•	2020 Public Use Microdata
•	2024 Public Use Microdata
2.	And we extracted monthly credit-market indicators from the Consumer Financial Protection Bureau (CFPB).
3.	The process involves verifying the release year, variable descriptions, and file integrity through SHA-like checks performed by the FRB. And we also inspected metadata for each file (frequency, units, geographic scope, definitions). And then parsed the data into Python.
4.	For the enrichment section, we added several analytically useful variables:
o	survey_year (e.g., 2020 vs 2024) to allow cross-wave comparisons.
o	credit-stress composite variables, created from SHED indicators (e.g., difficulty paying bills, credit card denial reasoning).These variables allow richer modeling of financial well-being.

