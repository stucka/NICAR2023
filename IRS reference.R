#################
# IRS reference #
#################

# this script imports, unzips and cleans tax-exempt organization files from IRS
# the files range in size from 90 MB to 236 MB

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
