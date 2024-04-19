#### Preamble ####
# Purpose: Clean the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages


#### Workspace setup ####
install.packages("tidyverse")
install.packages("readr")
install.packages("dplyr")
install.packages("janitor")
install.packages("lubridate")
install.packages("mice")
library(tidyverse)
library(readr)
library(dplyr)
library(lubridate)
library(janitor)
#### Clean data ####

# Reading the data with specified delimiter using read_delim separate columns
raw_data <- read.csv("/cloud/project/data/raw_data/raw_data.csv")

# Checking the first few rows to ensure it read correctly
head(raw_data)

# Variable Name
names(raw_data)

data_clean <- raw_data |>
  dplyr::select(-X,-ofagdp, -policytot, -debtrelief, -recaps, -tradeshare, -durables, -loss, -loss2, -INVSA, -CCC, - RZyoung, -n, -href, -contcrisis, -tradeshare, -expgrowthTRIM, -BANK_W3, -forbb, -forba, -liqsup, -blanguar, -homogeneity, -FL, -TANG,-pcrdbofgdp, -rznoncrisis)

view(data_clean)
data_clean$trade_count <- round(data_clean$tradevalue / 1000)


names(data_clean)
#### Save data ####
write_csv(data_clean, "/cloud/project/data/analysis_data/analysis_data.csv")
