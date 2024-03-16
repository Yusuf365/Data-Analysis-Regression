#### Preamble ####
# Purpose: Download the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages



#### Workspace setup ####
install.packages("readr")
install.packages("tidyverse")
install.packages("janitor")
library(readr)
library(tidyverse)
library(janitor)


#### Download data ####

url <- "https://data.leicester.gov.uk/api/explore/v2.1/catalog/datasets/covid-19-positive-tests-and-rate-per-100000-population-for-leicester-and-englan0/exports/csv"

# Read the CSV file using read_csv from the readr package
the_raw_datacovid_19_positive_tests_and_rate_per_100000_population_for_leicester_and_england <- read_csv(url)

# Print the first few lines of the data frame to check
head(the_raw_datacovid_19_positive_tests_and_rate_per_100000_population_for_leicester_and_england)




#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_datacovid_19_positive_tests_and_rate_per_100000_population_for_leicester_and_england, "data/raw_data/raw_data.csv") 

         
