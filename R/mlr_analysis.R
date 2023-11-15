#' Multiple linear model analysis
#'
#' This function calculates and analysis multiple linear regression
#'
#' @param formula a formula in form of response ~ predictor1 + predictor2 + ...
#' @param data a data frame containing all needed variables in the formula.
#'
#' @return the summary table which contains residuals, fitted_values, df,
#' coeff_table（which include Estimates, Std.Error, t value and p value,
#' R_squared, adj_R_squared, F_statistic, p-value of F_test and CI_95 of
#' the input multiple linear model.
#'
#' @examples
#'mlr_analysis(formula = mpg ~ hp + cyl, data = mtcars)
#'mlr_analysis(formula = mpg ~ hp + cyl + wt, data = mtcars)
#'mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec, data = mtcars)
#'mlr_analysis(formula = mpg ~ hp + cyl + wt + qsec + cyl * wt, data = mtcars)
#'
#' @export
#'

mlr_analysis = function(formula, dataset) {
  # Reform x and y from the input formula & Calculate n, p and df
  fulldata = na.omit(dataset) #get rid of NA in data set
  n = nrow(fulldata)
  p = length(labels(terms(formula))) + 1
  Y = fulldata[, as.character(formula[[2]]), drop = FALSE]
  y = as.matrix(Y, n, 1)
  x = model.matrix(formula, fulldata)
  df1 = p - 1
  df2 = n - p

  # Calculate Coefficients
  coeff = solve(t(x) %*% x) %*% t(x) %*% y

  # Calculate Fitted Value
  fitted_val = x %*% coeff

  # Calculate Residuals
  res = y - fitted_val

  # Calculate Standard Error
  var_cov_coef = as.vector((t(res) %*% res) / df2) * solve(t(x) %*% x)
  se = sqrt(diag(var_cov_coef))

  # Calculate t-values
  t_values = coeff / se

  # Calculate p-values
  p_values = 2 * (1 - pt(abs(t_values), df2))

  # Calculate F-value and p-value
  SSY = sum((y-mean(y))^2)
  SSE = t(res) %*% res
  SSR = SSY - SSE
  MSE = SSR / df1
  MSR = SSE / df2
  f_value = MSE/MSR
  f_p_val = pf(f_value, df1, df2, lower.tail = FALSE)

  # Calculate R-squared and adjusted R-squared
  r_square = SSR / SSY
  adj_r_square = 1 - (SSE / df2)/(SSY / (n-1))

  # Calculate bounds of CI (0.05)
  Lower_b = coeff - qt(0.05/2, df2, lower.tail = FALSE)*se
  Upper_b = coeff + qt(0.05/2, df2, lower.tail = FALSE)*se

  # From names of the results of coefficients, f test and CI
  coeff_comb = cbind(coeff, se, t_values, p_values)
  colnames(coeff_comb) = c("Estimates", "Std.Error", "t value", "p value")
  f_test = c(f_value, df1, df2)
  names(f_test) = c("F stat", "df1", "df2")
  CI = cbind(Lower_b, Upper_b)
  colnames(CI) = c("2.5%", "97.5%")

  # List all results out
  summary_result = list(
    coeff_table = coeff_comb,
    residuals = res,
    fitted_values = fitted_val,
    df = df2,
    R_squared = as.vector(r_square),
    adj_R_squared = as.vector(adj_r_square),
    F_stat = f_test,
    F_test_p = as.vector(f_p_val),
    CI_95 = CI
    )

  # Return a summary table as output
  return(list(summary_table = summary_result))
}

