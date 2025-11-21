# IS477-WJ
## Overview

The COVID-19 pandemic has had a profound and long-lasting impact on the global economy; therefore, household credit card debt is also influenced. This project aims to investigate how financial literacy and household credit card debt have changed after COVID-19. Our team will be using two large-scale datasets from the years 2020 and 2024 Federal Reserve’s Survey of Household Economics and Decisionmaking (SHED).

By comparing the 2020 and 2024 SHED datasets, this project will explore how levels of financial literacy, credit access, and repayment behavior have evolved in response to the pandemic’s lasting economic effects. The analysis will examine demographic variables such as income, age, and education level to identify which groups experienced the most significant changes in credit card usage and debt management. We will also consider economic influences to interpret shifts in household financial behavior.

Our approach combines data integration, cleaning, and statistical analysis to ensure a transparent and reproducible workflow. The findings will provide insights into how households adapted their financial strategies in the years following COVID-19 and last year of 2024 after COVID-19.  

The overall goal is to produce a reproducible, data-integrated analysis that would demonstrate how the pandemic and economic disruptions affect individuals’ financial decision-making and credit outcomes. Through the process of merging these two large federal datasets, we will illustrate multiple aspects of the data lifecycle and other techniques that were learned in class.

In addition to the technical aims, this project will contribute to a broader understanding of financial resilience: how knowledge, education, and access to certain financial resources influence households to make financial decisions and manage debt in a time of crisis. And by highlighting the difference between 2020 and 2024, we hope to address the importance of promoting household stability in an unstable economic setting.

## Research Question

1. Did the strength of the relationship between financial literacy and household credit card debt change after the COVID-19 pandemic?
2. Did households with higher financial literacy show smaller increases in debt post-COVID-19?



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
