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
library(tidyverse)
library(readr)
library(dplyr)
library(lubridate)
library(janitor)
#### Clean data ####

# Reading the data with specified delimiter using read_delim separate columns
raw_data <- read_delim("data/raw_data/raw_data.csv", delim = ";")

# Checking the first few rows to ensure it read correctly
head(raw_data)


clean_data <- drop_na(raw_data)


clean_data <- raw_data |>
  rename(
    AreaName = areaname,
    Date = date,
    NewCasesBySpecimenDate = newcasesbyspecimendate,
    NewCasesRatePer100k = newcasesbyspecimendaterollingrate,
    NewCasesRollingSum = newcasesbyspecimendaterollingsum
  )

head(clean_data)
names(clean_data)
head(clean_data$Date)

# Adding separate column for year, month, date

clean_data <- clean_data |>
  mutate(
    year = year(Date),  # Extract the year from the date column
    month = month(Date),
    day = day(Date)     # Extract the day from the date column
  )


#### Save data ####
write_csv(clean_data, "data/analysis_data/analysis_data.csv")
