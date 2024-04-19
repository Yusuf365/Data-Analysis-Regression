#### Preamble ####
# Purpose: Download the data
# Author: Mohammed Yusuf Shaikh
# Date: 7th March 2024
# Contact: mohammedyusuf.shaikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install Packages

install.packages("readr")
install.packages("MASS")
install.packages("rstanarm")
install.packages("bayesplot")
install.packages("modelsummary")
install.packages("AER")
install.packages("broom")
install.packages("stargazer")
library(stargazer)
library(readr)
library(MASS)
library(rstanarm)
library(bayesplot)
library(modelsummary)
library(ggplot2)
library(broom)
library(knitr)

data <- read_csv("data/analysis_data/analysis_data.csv")

















#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


