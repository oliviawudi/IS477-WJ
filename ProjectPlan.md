## Overview

The COVID-19 pandemic has had a profound and long-lasting impact on the global economy; therefore, household credit card debt is also influenced. This project aims to investigate how financial literacy and household credit card debt have changed after COVID-19. Our team will be using two large-scale datasets from the years 2020 and 2024 Federal Reserve’s Survey of Household Economics and Decisionmaking (SHED).

By comparing the 2020 and 2024 SHED datasets, this project will explore how levels of financial literacy, credit access, and repayment behavior have evolved in response to the pandemic’s lasting economic effects. The analysis will examine demographic variables such as income, age, and education level to identify which groups experienced the most significant changes in credit card usage and debt management. We will also consider economic influences to interpret shifts in household financial behavior.

Our approach combines data integration, cleaning, and statistical analysis to ensure a transparent and reproducible workflow. The findings will provide insights into how households adapted their financial strategies in the years following COVID-19 and last year of 2024 after COVID-19.  

The overall goal is to produce a reproducible, data-integrated analysis that would demonstrate how the pandemic and economic disruptions affect individuals’ financial decision-making and credit outcomes. Through the process of merging these two large federal datasets, we will illustrate multiple aspects of the data lifecycle and other techniques that were learned in class.

In addition to the technical aims, this project will contribute to a broader understanding of financial resilience: how knowledge, education, and access to certain financial resources influence households to make financial decisions and manage debt in a time of crisis. And by highlighting the difference between 2020 and 2024, we hope to address the importance of promoting household stability in an unstable economic setting.

## Research Question

Did the strength of the relationship between financial literacy and household credit card debt change after the COVID-19 pandemic?
Did households with higher financial literacy show smaller increases in debt post-COVID-19?
Do regional market conditions explain part of the change in debt behavior?


## Team

**Yeonjun Kim**

Role 
- Data lifecycle
- Data collection and acquisition
- Data cleaning
- Data quality
- Workflow automation and provenance
- Metadata and data documentation


Responsibility
1. Collect two datasets from the website called “Board of Governors of the Federal Reserve System” of the section called “Survey of Household Economics and Decisionmaking” in a JSON file for the year of the survey 2020 during COVID-19, and a comma separated values (CSV) file for 2024. 

2. Clean the dataset considering the missing values, rename the columns into meaningful names, outliers, syntactic or semantic terms.

3. Conduct data quality assessment covering consistency verifying attributes align across both datasets, accuracy confirming correctness, validity ensuring data types match the expected schema , and uniqueness identifying and removing duplicate records based on primary identifiers

4. Tracking provenance capture data transformations, file versions through git commits and descriptive comments
Workflow automation ensuring entire process from raw data import to final analysis with minimal error. 



**Wenqi Shan**

**Role**  
- Ethical data-handling 
- Storage and organization
- Extraction and Enrichment 
- Data integration
- Data Cleaning
- Reproducibility and transparency

**Responsibility**
1. Verify data licenses (Federal Reserve SHED); document compliance with open data terms.
2. Ensure citation and attribution of data sources in README, following the Federal Reserve attribution guidelines. 
3. Creating box folders to organize data, setting naming conventions for convenience. 
4. Extract variables that are relevant to our research goals (literacy, income, debt) from SHED; compute derived variables.
5. Apply cleaning scripts, including removing NaN values, and maintain clean data logs. 
6. Aggregate SHED data by region/year, will be using Pandas to merge datasets. After merging 
7. Write a reproducibility section in markdown to explain inputs, parameters, and assumptions. 


## Datasets

We are utilizing two large-scale datasets from the Federal Reserve’s Survey of Household Economics and Decisionmaking (SHED), one from 2020 during COVID-19 and another from 2024. 
It reflects the pandemic economic environment. Thse datasets contain valuable information about household financial conditions, spending habits, credit usage, and overall decision-making behaviors. 
To enable direct comparison, we will aggregate the two datasets into a single integrated file, clearly distinguishing records by year to track temporal changes. The 2020 SHED dataset will be imported in CSV format, while the 2024 dataset will be obtained in JSON format, allowing us to demonstrate how different data structures can be merged and anlyzed together.

**Survey of Household Economics and Decision-making**

https://www.federalreserve.gov/consumerscommunities/shed_data.htm




## Timeline

Week 1 (Oct/20 ~ 26)

- Jun : Data lifecycle

- Wenqi: ethical & data handling


Week2 (Oct/27 ~ Nov/2)
- Jun : Data collection and acquisition

- Wenqi: Data storage 

Week3 (Nov/3 ~ 9)
- Jun : Data quality

- Wenqi: extraction and enrichment, data integration


Week4 (Nov/10 ~ 9-16)
- Jun : Data cleaning

- Wenqi: Data cleaning

Week5 (Nov/17 ~ 23)
- Jun : Workflow automation and provenance

- Wenqi: Reproducibility & Transparency

Week6 (Nov/24 ~ 30)
- Jun : Metadata and data documentation

- Wenqi: Reproducibility & Transparency

Week7 (Nov/31 ~ Dec/7)
- Release to GitHub of completed project


## Constraints
1. We need to identify the governance heterogeneity, considering policy, licenses, or accessibility that would impact checking the usage of other datasets in terms of data policy, consent, license, and copyright.

2. We still have to think about what kind of model we would use to approach answering our research questions. 

3. We still need to explore our datasets, considering the meaningful usage of features to answer our research questions. 

4. We must check the ethical data handling perspective as ethical, legal, or policy constraints of how they are addressed.

5. By different categories from our project of finance and the lab coding instances, we need to adapt the coding on our finance perspective among our past lectures.




## Gaps

1. We do need to learn the concept of workflow automation and provenance, reproducibility and transparency, and metadata and data documentation for our later progress.

2. It is essential to look back for the ethical data handling concept for checking issues of data usage in terms of consent, privacy, copyright, license, and policy. 
	
3. Before conducting analysis, it is essential to review data documentation, codebooks, schema files, and metadata that are provided with each dataset fully understand the meaning and  context of all features. 

4. After understanding the documentation, identify meaningful analytical direction such as exploring the frequency, trends, and patterns in retraction, considering actionable insights by connecting metadata aiming to our research goals. 
