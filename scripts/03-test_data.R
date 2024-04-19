#### Preamble ####
# Purpose: Download the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

# Set the seed for reproducibility
set.seed(123)

# Load necessary libraries
library(dplyr)

# Number of rows to simulate
n <- 100

# Simulating data
simulated_data <- data.frame(
  exporter = sample(c("ARG", "BRA", "USA", "GER"), n, replace = TRUE),
  year = sample(1980:2020, n, replace = TRUE),
  product = sample(3000:3100, n, replace = TRUE),
  tradevalue = rnorm(n, mean = 1e6, sd = 5e5),
  tradeshare = runif(n, 0, 1),
  expgrowth = rnorm(n, mean = 0, sd = 0.2),
  BANK = rbinom(n, 1, 0.5),
  stmktcap = runif(n, 0, 0.1),
  RecessionAbroad = rbinom(n, 1, 0.2),
  GDPgrAbroad = rnorm(n, mean = 2, sd = 1),
  durables = sample(0:1, n, replace = TRUE),
  loss = runif(n, 0, 0.1),
  loss2 = runif(n, 0, 0.1),
  GDPcap = rnorm(n, mean = 50000, sd = 10000),
  GDPgr = rnorm(n, mean = 3, sd = 1),
  INVSA = runif(n, 0, 1),
  CCC = runif(n, 0, 1),
  RZyoung = runif(n, 0.5, 0.7),
  rznoncrisis = runif(n, 0, 0.1),
  caplab = rnorm(n, mean = 25, sd = 5),
  rd = runif(n, 0, 0.02),
  homogeneity = runif(n, 0, 1),
  n = rnorm(n, mean = 1.5, sd = 0.5),
  herf = runif(n, 0.4, 0.6),
  intout = runif(n, 1, 3),
  contcrisis = sample(0:1, n, replace = TRUE),
  tradc_count = rnorm(n, mean = 1000, sd = 300)
)


#### Test data ####


# Test data types
test_that("variables are expected type", {
  expect_type(simulated_data$exporter, "character")
  expect_type(simulated_data$year, "integer")
  expect_type(simulated_data$product, "integer")
  expect_type(simulated_data$tradevalue, "double")
  expect_type(simulated_data$tradeshare, "double")
  expect_type(simulated_data$expgrowth, "double")
  expect_type(simulated_data$BANK, "integer")
  # Add other variables as needed
})

# Test for null values
test_that("variables do not have null values", {
  expect_false(any(is.na(simulated_data$exporter)))
  expect_false(any(is.na(simulated_data$year)))
  expect_false(any(is.na(simulated_data$product)))
  # Continue with other columns as necessary
})

# Categorical field validation
test_that("exporter contains only expected categories", {
  valid_exporters <- c("ARG", "BRA", "USA", "GER")
  expect_true(all(simulated_data$exporter %in% valid_exporters))
})
