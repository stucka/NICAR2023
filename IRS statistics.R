##################
# IRS statistics #
##################

# set working directory and load packages
setwd()
library(tidyverse)
library(readxl)

# financial info on most nonprofits is available at 
# https://www.irs.gov/statistics/soi-tax-stats-annual-extract-of-tax-exempt-organization-financial-data
# The organizations are identified by EINs (Employer Identification Number). 
# To get names and other identifying info, combine with Business Master File.

# The 2021 files range in size from 377 MB for 990s to 95 MB for 990-PFs to 68 MB for 990-EZs.
# The file 21eofinextractdoc.xlsx is a data dictionary for all three data workbooks; it's in the Data folder.

# In this script we use a 1.6 MB random sample of the 2021 990 file.

