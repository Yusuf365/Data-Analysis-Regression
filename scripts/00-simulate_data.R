#### Preamble ####
# Purpose: Download the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages

#### Workspace setup ####
library(tidyverse)
library(tibble)
library(lubridate)
library(ggplot2)
# Number of days to simulate
num_days <- 100

# Generate a date sequence
start_date <- as.Date("2023-01-01")
date_sequence <- seq.Date(start_date, by = "day", length.out = num_days)

# Simulate data
simulated_data <- tibble(
  AreaName = rep("England", num_days),
  Date = date_sequence,
  NewCasesBySpecimenDate = sample(400:1000, num_days, replace = TRUE),
  NewCasesRatePer100k = runif(num_days, 5, 15),
  NewCasesRollingSum = sample(3000:6000, num_days, replace = TRUE),
  year = year(Date),
  month = month(Date),
  day = day(Date)
)

# Print the first few rows
print(head(simulated_data))


ggplot(simulated_data, aes(x = Date, y = NewCasesRatePer100k)) +
  geom_line() + # Line graph
  geom_point(aes(color = factor(year))) + # Points colored by year
  labs(title = "New Cases Rate per 100k Over Time",
       x = "Date",
       y = "New Cases Rate per 100k",
       color = "Year") +
  theme_minimal()



