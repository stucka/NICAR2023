#################
# IRS reference #
#################

# this script imports, unzips and cleans tax-exempt organization files from IRS
# the files range in size from 90 MB to 236 MB

# set working directory, then load packages (must be installed first)
setwd()
library(tidyverse)
library(httr)
library(lubridate)

# import Publication 78 list of orgs that can accept tax-deductible contributions
temp1 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-pub78.zip", temp1, 
              mode = "wb")
unzip(temp1,"data-download-pub78.txt") 
unlink(temp1)
Charities <- read_delim("data-download-pub78.txt", delim="|", skip = 2, 
                        col_names = FALSE)
                        
# View Charities data frame - six unnamed columns 
View(Charities)

# add names to columns in Charities data frame
colnames(Charities)[1] <- 'EIN'
colnames(Charities)[2] <- 'Organization'
colnames(Charities)[3] <- 'City'
colnames(Charities)[4] <- 'State'
colnames(Charities)[5] <- 'Country'
colnames(Charities)[6] <- 'Type'

# import list of nonprofits that lost their tax-exempt status
temp2 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-revocation.zip", 
              temp2, mode = "wb")
unzip(temp2, "data-download-revocation.txt")
unlink(temp2)
Revoked <- read_delim("data-download-revocation.txt", delim = "|", skip = 2,
                      col_names = FALSE)

# View Revoked data frame - 12 unnamed columns
View(Revoked)

# add names to columns in Revoked data frame
colnames(Revoked)[1] <- 'EIN'
colnames(Revoked)[2] <- 'Organization'
colnames(Revoked)[3] <- 'OrgSuffix'
colnames(Revoked)[4] <- 'Address'
colnames(Revoked)[5] <- 'City'
colnames(Revoked)[6] <- 'State'
colnames(Revoked)[7] <- 'ZIP'
colnames(Revoked)[8] <- 'Country'
colnames(Revoked)[9] <- 'Exempt'
colnames(Revoked)[10] <- 'Date1'
colnames(Revoked)[11] <- 'Date2'
colnames(Revoked)[12] <- 'Date3'

# convert date fields in Revoked from character to date format
Revoked <- Revoked %>% 
  mutate(Date1 = dmy(Date1),
         Date2 = dmy(Date2),
         Date3 = dmy(Date3))

