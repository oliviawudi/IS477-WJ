# Updates 
## 1. Project Pan (Based on Feedback)
To address feedback encouraging integration of our data from multiple sources, we expanded our project by adding an external dataset from the Consumer Financial Protection Bureau (CFPB). Unlike the Federal Reserve’s SHED data, which mostly captures household-level experiences and perceptions, the CFPB dataset would provide macro-level indicators, including things like monthly trends in credit card originations, inquiries, and borrowing activity. We decided to acquire those data by SAS file on SHED dataset of the year 2024 and 2020, and CSV file on CFPB data.

The CFPB of Consumer Credit Trends dataset provides monthly, nationwide information on new credit card originations. It includes the total dollar volume of new credit card limits issued to different credit score groups, ranging from deep subprime to super-prime borrowers. The dataset contains both seasonally adjusted and unadjusted lending volumes, allowing analysis of raw lending activity as well as smoothed long-term trends from the year 2007 Jan to 2025 Apr. Each row represents one credit score category for a given month. This dataset helps us understand how lending patterns differ across borrower risk levels.

This new dataset will allow us to enrich SHED respondents’ financial experiences with contextual information about the broader credit environment. Adding the CFPB dataset introduces some challenges in the data integration process, which strengthens the methodological rigor of our project. 

We also deleted the third research question of "Do regional market conditions explain part of the change in debt behavior?" because there was no information about the market region in SHED dataset. We will focus on the financial literacy and credit card payment behavior through our research project. 

## 2. Timeline
Week5 (Nov/17 ~ 23)
Jun: Data Cleaning & Data Analysis

Wenqi: Data Cleaning & Data Analysis


Week6 (Nov/24 ~ 30)
Jun: Workflow automation and provenance

Wenqi: Reproducibility & Transparency

Week7 (Nov/31 ~ Dec/7)
Jun: Metadata and data documentation

Release to GitHub of the completed project





## 3. Contributions Task

### **Jun**	
After submitting the Project Plan, we received feedback regarding the aggregation of the SHED dataset across different years. They wanted us to have a challenging experience of data management through this final project. 
We decided to find another dataset that aligns with our research question of credit card status, specifically the CFPB Consumer Credit Trends dataset. So I added its dataset in our data lifecycle on the plan and collect/acquire section for its update. 
Considering our feedback, we searched the dataset for more information about credit card behavior, and we reached the government dataset of Consumer Credit Trends. We decided to aggregate on the lending levels of credit card risk that describe the credit card limit volume that the bank distributed by credit score status group. 
Building the pipeline of our final project in our introduction page  of our GitHub in terms of our research goal of understanding financial literacy and credit card usage behavior across the United States. I described the plan section of what we did so far. Additionally, I included the information about our datasets in the Collect / Acquire section and its details explained on the Google Colab file. 


For the data quality, I dive into SHED and CFPB datasets exploring each rows and features by Google Colab describing their information in details. I have found the data quality of fitness for use:

**SHED 2024**

For completeness, there were no explicit missing values in the selected values considered by the research question. However, the implicit missing values were found on the EF2 feature with an empty string in over 50%. I decided to drop that feature to preserve its representative dataset. Also, I found there was 15% on the C4A feature and dropped those missing values of rows due to less percentage. 

For Semantic Accuracy, we identified its feature meaning through the document:
credit card
C2A — Credit card ownership
C4A — Frequency of carrying an unpaid balance
Financial Literacy
EF1 — Has emergency savings
EF2 — Ability to cover 3 months if income is lost
EF3 - Suppose that you have an emergency expense that costs $400. Based on your current financial situation, how would you pay for this expense?
EF3_a — Put it on my credit card and pay it off in full at the next statement
EF3_b — Put it on my credit card and pay it off over time
EF3_c — With the money currently in my checking/savings account or with cash
EF3_d — Using money from a bank loan or line of credit
EF3_e — By borrowing from a friend or family member
EF3_f — Using a payday loan, deposit advance, or overdraft
EF3_g — By selling something
EF3_h — I wouldn't be able to pay for the expense right now

We tested for logical contradictions. People who answered yes for EF2 with answering no for EF3, we found 3 cases and removed 3 rows considering the contradiction. Additionally, we check the contradiction between C2A and C4A. There was no contradiction that nobody without a credit card reported credit card repayment behavior. 

For syntactic accuracy, most of the binary surveys of features answered yes or no correctly. Additionally, the EF2 feature had invalid empty strings, and we dropped it entirely because more than 50% was missing implicitly. At last, C4A contained a low percentage of empty string, and we just dropped those rows instead of dropping that feature to preserve as representative data. 

The 1,948 rows were removed and EF2 feature were dropped due to implicit missing values. 

**SHED 2020**

There were format differences compare to the 2024 dataset that it formed as numeric 0.0 of no, 1.0 of yes, and -1.0 of  refused to response.
The completeness was described with C4A that it had 13.8% of implicit missing values and we dropped those rows. Several variables were used -1 indicating refusal of  response. We removed those rows due to low percentage of the entire data. 

For semantics, we used EF1 to compare the meaning response of the EF3 series of emergency payment options, and there was no contradiction. The C2A of credit ownership had no contradiction of response from the C4A of payment cover. 

For Syntactic, many features are stored incorrectly as 0., 1. Instead of 0.0 or 1.0. We converted all binary features and the C4A feature to an integer format as Int64 to standardize their responses. 

Total of 1,711 rows were dropped with all syntactic inconsistencies corrected. 

**CFPB**

For completeness, there were no explicit and implicit missing values. The date and credit score group contained no empty strings as well.

For semantic checks, the vol and vol_unadj features did not have negative values, and they were consistent and similar in magnitude. Additionally, the credit score group categories are correctly labeled in Deep subprime, Subprime, Near-prime, Prime, and Super-prime. Lastly, all 5 credit score groups appear exactly once for each month  with presenting a consistent data structure.

For syntactic, the numeric features of month, vol, and vol_unadj have correct types. The date format was consistent across the dataset. Finally, the credit score group string was valid as well. 

There were no rows dropped. The dataset did not require cleaning, only interpretation.


### Wenqi
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
of	CFPB makes Consumer Credit Trends available under an open public license, but use must follow the terms of use and attribution requirements.
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

