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

stan_poisson_model <- stan_glm(trade_count ~ GDPgr + GDPgrAbroad + BANK, 
                               family = poisson(link = "log"), 
                               data = data, 
                               chains = 4, 
                               iter = 2000,
                               seed = 12345)

# Summarize the results
summary(stan_poisson_model)

coef(stan_poisson_model)

prior_summary(stan_poisson_model)

stan_nb_model <- stan_glm(trade_count ~ GDPgr + GDPgrAbroad + BANK, 
                          family = neg_binomial_2(link = "log"), 
                          data = data, 
                          chains = 4, 
                          iter = 2000,
                          seed = 12345)

# Summarize the results
summary(stan_nb_model)


coef(stan_nb_model)

prior_summary(stan_nb_model)












#### Save model ####
saveRDS(
  stan_poisson_model,
  file = "/cloud/project/models/first_model.rds"
)


saveRDS(
  stan_nb_model,
  file = "/cloud/project/models/second_model.rds"
)

