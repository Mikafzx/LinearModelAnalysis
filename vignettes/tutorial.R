## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(LinearModelAnalysis)
library(bench)
data("mtcars")

## -----------------------------------------------------------------------------
mymodel1 = mlr_analysis(formula = mpg ~ hp + cyl + wt, data = mtcars)
mymodel1

## -----------------------------------------------------------------------------
mymodel2 = mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec + cyl * wt, data = mtcars)
mymodel2

## -----------------------------------------------------------------------------
# fit the model which contains interaction with original lm function
lm_model = lm(mpg ~ hp + cyl + wt + qsec + cyl * wt, data = mtcars)
sum_lm = summary(lm_model)
lm_model
sum_lm

## ----result comparisons-------------------------------------------------------
# compare the coefficients between two functions
all.equal(as.numeric(mymodel2$coeff_table), as.numeric((sum_lm)$Coefficients))
bench::mark(as.numeric(mymodel2$coeff_table), as.numeric((sum_lm)$Coefficients))

# compare the residuals between two functions
all.equal(as.numeric(mymodel2$summary_table$residuals), as.numeric(lm_model$residuals))
bench::mark(as.numeric(mymodel2$summary_table$residuals), as.numeric(lm_model$residuals))

# compare the df between two functions
all.equal(as.numeric(mymodel2$df), as.numeric(sum_lm$DF))
bench::mark(as.numeric(mymodel2$df), as.numeric(sum_lm$DF))

## ----speed comparisons--------------------------------------------------------
speed1 = bench::mark(as.numeric(mymodel2$coeff_table), as.numeric((sum_lm)$Coefficients))
speed1

speed2 = bench::mark(as.numeric(mymodel2$summary_table$residuals), as.numeric(lm_model$residuals))
speed2

speed3 = bench::mark(as.numeric(mymodel2$df), as.numeric(sum_lm$DF))
speed3

