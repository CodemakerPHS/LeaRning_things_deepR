#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  Data Masking
#  NES KIND Intermediate R 6 Aug 2025
#  With Brendan Clarke
#
#
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



library(NHSRdatasets)
library(dplyr)
library(purrr)

stranded_data["age"] |>
  head(7)

stranded_data |>
  select(age) |>
  head(7)

