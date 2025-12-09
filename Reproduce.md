# Reproducing This Project
This document describes how to reproduce the full analysis pipeline for the IS 477 final project on financial literacy, credit card debt, and post-COVID household behavior using Federal Reserve SHED and CFPB data.
The goal is that someone with access to the data and this repository can regenerate all cleaned data, analysis outputs, and visualizations.

# Pre-req
You will have to be running our scripts:
- git
- python >= 3.10
- pip
- snakemake
- A unix-like shell

# Directory Structure

# Set up the Python Enviroment
- Create and acticate a virtual enviroment
- Install dependencies
- Install Snakemake

# Obtain the data 
- The SHED data are public-use but cannot be redistributed via this repository. You must download them directly from the Federal Reserve:
1. Link to Federal Reserve SHED data portal: https://www.federalreserve.gov/consumerscommunities/shed.htm
2. Download the following files: a) 2020 SHED microdata (CSV) b) 2024 SHED microdata (sas7bdat)
3. Save them to 
