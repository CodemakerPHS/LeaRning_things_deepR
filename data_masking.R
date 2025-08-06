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

stranded_data |>
  select("age") |>
  head(7)

# suppoly quoted col name and get back a 1-col tibble
# Base R??
masc_fun <- function(the_df, the_col_name){
  the_result <- the_df[the_col_name]
  return(the_result)
}

masc_fun(stranded_data, "age")

tidy_mask_fun <- function(the_col_name){
  the_tidy_result <- stranded_data[the_col_name]
  return(the_tidy_result)
}
tidy_mask_fun("age")
tidy_mask_fun(age)

tidy_embraced_mask_fun <- function(the_col_name){
  the_tidy_result <- stranded_data |>
    select({{the_col_name}})
  return(the_tidy_result)
}
#tidy_embraced_mask_fun("age")
tidy_embraced_mask_fun(age)
