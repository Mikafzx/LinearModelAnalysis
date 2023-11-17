test_that("mlr_analysis works", {
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl, input_data = mtcars)$coeff_table),
               as.numeric(lm(mpg ~ hp + cyl, mtcars)$coeff_table))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl, input_data = mtcars)$df),
               as.numeric(summary(lm(mpg ~ cyl + wt, mtcars))$DF))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt, input_data = mtcars)$coeff_table),
               as.numeric(lm(mpg ~ hp + cyl + wt, mtcars)$coeff_table))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt, input_data = mtcars)$df),
               as.numeric(lm(mpg ~ hp + cyl + wt, mtcars)$DF))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec, input_data = mtcars)$coeff_table),
               as.numeric(lm(mpg ~ hp + cyl + wt + qsec, mtcars)$coeff_table))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec, input_data = mtcars)$df),
               as.numeric(summary(lm(mpg ~ hp + cyl + wt + qsec, mtcars))$DF))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec + cyl * wt, input_data = mtcars)$coeff_table),
               as.numeric(lm(mpg ~ hp + cyl + wt + qsec + cyl * wt, mtcars)$coeff_table))
  expect_equal(as.numeric(mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec + cyl * wt, input_data = mtcars)$df),
               as.numeric(summary(lm(mpg ~ hp + cyl + wt + qsec + cyl * wt, mtcars))$DF))
})
