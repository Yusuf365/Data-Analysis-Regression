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

View(data)

























# Plotting the distribution of New Cases Rate per 100k
ggplot(data, aes(x = NewCasesRatePer100k)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  geom_density(alpha = 0.2, fill = "#FF6666") +
  labs(title = "Distribution of New Cases Rate per 100k",
       x = "New Cases Rate per 100k", y = "Frequency")

# Defining the Negative Binomial model
nb_model <- glm.nb(NewCasesRatePer100k ~ month + year, data = data)

# Summarizing the model
summary(nb_model)

# First, create a data frame from the model summary (similar to what we would have done here)
model_summary_df <- data.frame(
  Term = c("(Intercept)", "month", "year"),
  Estimate = c(1.620e+03, -1.059e-01, -7.986e-01),
  `Std. Error` = c(4.297e+01, 6.973e-03, 2.125e-02),
  `z value` = c(37.71, -15.19, -37.58),
  `Pr(>|z|)` = c("<2e-16", "<2e-16", "<2e-16")
)

# Then use kable to create the table
library(knitr)
kable(model_summary_df, caption = "Summary of Negative Binomial Regression Model")


# Residuals plot
plot(nb_model$residuals, type = 'p', main = "Residuals Plot",
     xlab = "Fitted values", ylab = "Residuals")
abline(h = 0, col = "red")


# Create a data frame of predictions
predict_data <- expand.grid(month = 1:12, year = unique(data$year))
predict_data$NewCasesRatePer100k_pred <- predict(nb_model, newdata = predict_data, type = "response")

# Plotting
ggplot(predict_data, aes(x = month, y = NewCasesRatePer100k_pred, group = year, color = as.factor(year))) +
  geom_line() +
  geom_point() +
  labs(title = "Predicted New Cases Rate per 100k by Month and Year",
       x = "Month", y = "Predicted New Cases Rate per 100k") +
  scale_color_discrete(name = "Year")



# Adding predictions to the dataset
data$predicted <- predict(nb_model, type = "response")

# Plot actual vs. predicted values
ggplot(data, aes(x = predicted, y = NewCasesRatePer100k)) +
  geom_point(alpha = 0.5) +
  geom_line(aes(x = predicted, y = predicted), color = "red") +
  labs(title = "Actual vs. Predicted New Cases Rate per 100k", x = "Predicted", y = "Actual")


# Model Summary Table

stargazer(nb_model, type = "text", header = FALSE, title = "Model Summary")

library(knitr)

# Assuming you have a summary of the model stored in nb_model_summary
nb_model_summary <- summary(nb_model)

# Create a dataframe to store the coefficients
model_coefficients <- data.frame(
  Term = rownames(nb_model_summary$coefficients),
  Estimate = nb_model_summary$coefficients[, "Estimate"],
  StdError = nb_model_summary$coefficients[, "Std. Error"],
  zValue = nb_model_summary$coefficients[, "z value"],
  pValue = nb_model_summary$coefficients[, "Pr(>|z|)"]
)

# Create a kable table
kable(model_coefficients, format = "markdown", col.names = c("Term", "Estimate", "Standard Error", "Z Value", "P Value"), caption = "Summary of Negative Binomial Regression Model")


# Basic information from the model
# Model Fit Statistics
model_info <- data.frame(
  LogLikelihood = logLik(nb_model),
  AIC = AIC(nb_model),
  BIC = BIC(nb_model)
)

# Displaying the model information
print(model_info)

# Using knitr for a nicely formatted table of model fit statistics
model_summary <- glance(nb_model)
kable(model_summary, caption = "Model Fit Statistics")






# Assuming 'data' is already loaded and prepared as per your previous script

# Defining the Poisson model
# Negative Binomial Model
nb_model <- glm.nb(NewCasesRatePer100k ~ month + year, data = data)

# Poisson Model
poisson_model <- glm(NewCasesRatePer100k ~ month + year, family = poisson(link = "log"), data = data)

# Summaries to compare the models
summary(nb_model)
summary(poisson_model)

# Overdispersion Test for Poisson Model
# A common rule of thumb: if the value is considerably greater than 1, it suggests overdispersion.
poisson_overdispersion_value <- sum(resid(poisson_model, type = "pearson")^2) / poisson_model$df.residual
print(paste("Overdispersion test value for Poisson Model:", poisson_overdispersion_value))

# Comparing AIC as a measure of model fit; lower AIC indicates a better fit
aic_nb <- AIC(nb_model)
aic_poisson <- AIC(poisson_model)
cat("Negative Binomial Model:", aic_nb, "\n")
cat("Poisson Model:", aic_poisson, "\n")

# Adding predictions to the dataset for comparison
data$nb_predicted <- predict(nb_model, type = "response")
data$poisson_predicted <- predict(poisson_model, type = "response")

# Actual vs. Predicted - Poisson
ggplot(data, aes(x = poisson_predicted, y = NewCasesRatePer100k)) +
  geom_point(alpha = 0.5, color = "red") +
  geom_line(aes(x = poisson_predicted, y = poisson_predicted), color = "red") +
  labs(title = "Actual vs. Poisson Predicted New Cases Rate per 100k", x = "Predicted (Poisson)", y = "Actual")

# Visual comparison of predictions from both models on the same plot for direct comparison


# Comparison table
stargazer(nb_model, poisson_model, type = "text",
          title = "Comparison of Negative Binomial and Poisson Models",
          out = "models_comparison_table.txt", # Saving the table to a file, optional
          model.names = FALSE,
          align = TRUE,
          column.labels = c("Negative Binomial", "Poisson"),
          covariate.labels = c("Intercept", "Month", "Year"),
          omit.stat = c("ll", "ser"),
          digits = 3,
          intercept.bottom = FALSE,
          star.cutoffs = NA, # Remove significance stars; add if desired
          no.space = TRUE,
          single.row = TRUE)


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


