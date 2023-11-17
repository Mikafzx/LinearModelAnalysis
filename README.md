
<!-- README.md is generated from README.Rmd. Please edit that file -->

# LinearModelAnalysis

<!-- badges: start -->

[![R-CMD-check](https://github.com/Mikafzx/LinearModelAnalysis/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Mikafzx/LinearModelAnalysis/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Mikafzx/LinearModelAnalysis/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Mikafzx/LinearModelAnalysis?branch=main)
<!-- badges: end -->

The goal of LinearModelAnalysis is to reproduce the result of lm() and
summary(), output the residuals, fitted_values, df, coeff_table（which
include Estimates, Std.Error, t value and p value), R_squared,
adj_R_squared, F_statistic, p-value of F_test and CI_95 of the fitted
model.

## Installation

You can install this package with the following code:

``` r
# install.packages("devtools")
devtools::install_github("Mikafzx/LinearModelAnalysis")
#> Downloading GitHub repo Mikafzx/LinearModelAnalysis@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/_7/c92zlqq17bscf5trz0z8hz040000gn/T/RtmpAfN1hv/remotesd7c7a9e2e8/Mikafzx-LinearModelAnalysis-eb16e1d/DESCRIPTION’ ... OK
#> * preparing ‘LinearModelAnalysis’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Omitted ‘LazyData’ from DESCRIPTION
#> * building ‘LinearModelAnalysis_0.1.0.tar.gz’
#> Installing package into '/private/var/folders/_7/c92zlqq17bscf5trz0z8hz040000gn/T/Rtmp0ystnN/temp_libpathd69a285cecea'
#> (as 'lib' is unspecified)
```

## Example

This is an example on how to use the package.

``` r
library(LinearModelAnalysis)
data(mtcars)
mymodel = mlr_analysis(formula = mpg ~ hp + cyl + wt, input_data = mtcars)
```
