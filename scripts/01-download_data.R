#### Preamble ####
# Purpose: Download the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages
# Download .dta data file from link: https://www.openicpsr.org/openicpsr/project/114179/version/V1/view?path=/openicpsr/114179/fcr:versions/V1/Data.dta&type=file


#### Workspace setup ####
install.packages("readr")
install.packages("tidyverse")
install.packages("janitor")
install.packages("haven")
library(readr)
library(tidyverse)
library(janitor)
library(haven)



# Downlaod Data.dta using haven readable dta file in R

raw_data <- read.csv("/cloud/project/finaldataset_1.csv")

head(raw_data)


#### Save data ####

write.csv(raw_data, "data/raw_data/raw_data.csv")

         
