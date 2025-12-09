# IS477-WJ
## Contributors 
Jun Kim

Wenqi Shan
## Summary

The COVID-19 pandemic has had a profound and long-lasting impact on the global economy; therefore, household credit card debt is also influenced. This project aims to investigate how financial literacy and household credit card debt have changed after COVID-19. Our team will be using two large-scale datasets from the years 2020 and 2024 Federal Reserve’s Survey of Household Economics and Decisionmaking (SHED).

By comparing the 2020 and 2024 SHED datasets, this project will explore how levels of financial literacy, credit access, and repayment behavior have evolved in response to the pandemic’s lasting economic effects. The analysis will examine demographic variables such as income, age, and education level to identify which groups experienced the most significant changes in credit card usage and debt management. We will also consider economic influences to interpret shifts in household financial behavior.

Our approach combines data integration, cleaning, and statistical analysis to ensure a transparent and reproducible workflow. The findings will provide insights into how households adapted their financial strategies in the years following COVID-19 and last year of 2024 after COVID-19.  

The overall goal is to produce a reproducible, data-integrated analysis that would demonstrate how the pandemic and economic disruptions affect individuals’ financial decision-making and credit outcomes. Through the process of merging these two large federal datasets, we will illustrate multiple aspects of the data lifecycle and other techniques that were learned in class.

To address feedback encouraging integration of our data from multiple sources, we expanded our project by adding an external dataset from the Consumer Financial Protection Bureau (CFPB). Unlike the Federal Reserve’s SHED data, which mostly captures household-level experiences and perceptions, the CFPB dataset would provide macro-level indicators, including things like monthly trends in credit card originations, inquiries, and borrowing activity.

In addition to the technical aims, this project will contribute to a broader understanding of financial resilience: how knowledge, education, and access to certain financial resources influence households to make financial decisions and manage debt in a time of crisis. And by highlighting the difference between 2020 and 2024, we hope to address the importance of promoting household stability in an unstable economic setting.

## Data Profile 
SHED 2020: 

SHED 2024:

CFPB: 
## Data Quality
### **SHED 2024**

For completeness, there were no explicit missing values in the selected values considered by the research question. However, the implicit missing values were found on the EF2 feature with an empty string in over 50%. I decided to drop that feature to preserve its representative dataset. Also, I found there was 15% on the C4A feature and dropped those missing values of rows due to less percentage. 

For Semantic Accuracy, we identified its feature meaning through the document:

credit card

- C2A — Credit card ownership
  
- C4A — Frequency of carrying an unpaid balance
Financial Literacy
- EF1 — Has emergency savings
- EF2 — Ability to cover 3 months if income is lost
- EF3 - Suppose that you have an emergency expense that costs $400. Based on your current financial situation, how would you pay for this expense?
  - EF3_a — Put it on my credit card and pay it off in full at the next statement
  - EF3_b — Put it on my credit card and pay it off over time
  - EF3_c — With the money currently in my checking/savings account or with cash
  - EF3_d — Using money from a bank loan or line of credit
  - EF3_e — By borrowing from a friend or family member
  - EF3_f — Using a payday loan, deposit advance, or overdraft
  - EF3_g — By selling something
  - EF3_h — I wouldn't be able to pay for the expense right now

We tested for logical contradictions. People who answered yes for EF2 with answering no for EF3, we found 3 cases and removed 3 rows considering the contradiction. Additionally, we check the contradiction between C2A and C4A. There was no contradiction that nobody without a credit card reported credit card repayment behavior. 

For syntactic accuracy, most of the binary surveys of features answered yes or no correctly. Additionally, the EF2 feature had invalid empty strings, and we dropped it entirely because more than 50% was missing implicitly. At last, C4A contained a low percentage of empty string, and we just dropped those rows instead of dropping that feature to preserve as representative data. 

The 1,948 rows were removed and EF2 feature were dropped due to implicit missing values. 

### **SHED 2020**

There were format differences compare to the 2024 dataset that it formed as numeric 0.0 of no, 1.0 of yes, and -1.0 of  refused to response.
The completeness was described with C4A that it had 13.8% of implicit missing values and we dropped those rows. Several variables were used -1 indicating refusal of  response. We removed those rows due to low percentage of the entire data. 

For semantics, we used EF1 to compare the meaning response of the EF3 series of emergency payment options, and there was no contradiction. The C2A of credit ownership had no contradiction of response from the C4A of payment cover. 

For Syntactic, many features are stored incorrectly as 0., 1. Instead of 0.0 or 1.0. We converted all binary features and the C4A feature to an integer format as Int64 to standardize their responses. 

Total of 1,711 rows were dropped with all syntactic inconsistencies corrected. 

### **CFPB**

There are 1100 rows and 5 columns. The rows represents how much volumes of credit card released from the bank in each group of credit score. The each feature represents:

- month - Months obervation count from 2000 Jan.

- date - Observation date

- vol - Clean up version of vol_unadj that remove seasonal effects.

- vol_unadj -The actual total dollar volumn of new credit cards opened that month, which the actual money the bank gave out.

- credit_score_group - Divided each group by the credit score as:

  - Deep subprime : <580
  - Subprime : 580 ~ 619
  - Near-prime : 620 ~ 659
  - Prime : 660 ~ 719
  - Super-prime : 720+

For completeness, there were no explicit and implicit missing values. The date and credit score group contained no empty strings as well.

For semantic checks, the vol and vol_unadj features did not have negative values, and they were consistent and similar in magnitude. Additionally, the credit score group categories are correctly labeled in Deep subprime, Subprime, Near-prime, Prime, and Super-prime. Lastly, all 5 credit score groups appear exactly once for each month  with presenting a consistent data structure.

For syntactic, the numeric features of month, vol, and vol_unadj have correct types. The date format was consistent across the dataset. Finally, the credit score group string was valid as well. 

There were no rows dropped. The dataset did not require cleaning, only interpretation.


## Research Question

1. Did the strength of the relationship between financial literacy and household credit card debt change after the COVID-19 pandemic?
2. Did households with higher financial literacy show smaller increases in debt post-COVID-19?

## Reproducibility and Transparency: 
To ensure full reproducibility and transparency, we have created a complete reproducible research package that allows anyone to re-run our entire workflow
1. Documentation describing how to reproduce the analysis
We have posted a dedicated reproduce.md that outlines each step required to reproduce the workflow.
This includes instructions for:
- Setting up the Python environment
- Downloading SHED data from the Federal Reserve website
- Running the Snakemake workflow
- Locating and interpreting the output files
2. Box Storage
Link: https://uofi.box.com/s/ietmow5zmh9ewrgu13qb431de4x3euce
Following the course requirement, there are :
- All output files and original csvs to a Box folder.
- Ensured the link is publicly accessible to course graders.
- Verified permissions 12+ hours before the deadline.
- Added the Box data directory to .gitignore to avoid pushing large or restricted files to GitHub.
This ensures reproducibility while respecting licensing rules.
3. All code, workflow scripts, and automation tools
4. Actual results including output data, visualizations, and tables
- These are included in the jypter notebook we proveded.
- As well as, the box folder
5. Specification of software dependencies
- A requirements.txt listing all libraries needed to run the workflow.
- A  pip freeze snapshot for exact reproducibility of the environment.
- The environment documentation includes:
a) Python version
b) Operating system details
c) Any optional tools (e.g., Jupyter, Snakemake version)



# Data Lifecycle
## 1. Plan
- Defined the core research questions, focusing on relationship between **financial literacy** and **household credit card debt changed between the year 2020 during COVID-19 and 2024 after that term.

- Selected our primary data source as the **Federal Reserve's Survey of Household Economics and Decision-Making (SHED)** for 2020 and 2024.

- Selected a complementary contextual dataset, the **Credit Card Dataset** of **Borrower Risk Pofiles (CFPB)** to capture broader credit risk and lending conditions.

- Identified key concepts of financial literacy, credit card debt, incomme, and risk category for the variables we expect to extract and derive.

- Assigned roles and responsibilities.

## 2. Collect / Acquire
We obtain data from original source in: 

- SHED 2020 and 2024 : https://www.federalreserve.gov/consumerscommunities/shed_data.htm  
  - Source : Board of Governors of the Federal Reserve System
  - Format : SAS file
  - Action : Download SAS file and documentation, converting the SAS file to CSV with analyzing its documentation.

- CFPB : https://www.consumerfinance.gov/data-research/consumer-credit-trends/credit-cards/borrower-risk-profiles/#anchor_lending-levels 
  - Source : CFPB Consumer Credit Trends of borrower risk profiles (Lending Levels)
  - Format : CSV
  - Action : Download and save as raw CSV for later aggregation and integration.
 

## 3. Store & Organize

## 4. Integrate & Enrich

## 5. Quality & Clean

## 6. Analyze

## 7. Preserve & Share

