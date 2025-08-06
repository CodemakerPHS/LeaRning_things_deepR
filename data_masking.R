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

# Pronouns
col_pick_pronouns <- function(a_col){
 stranded_data |>
    select(.data[[a_col]])
  
}
col_pick_pronouns("age") # warning
# But I wouldn't try to write lots of functions that get you to 
# pass in params quoted, 
# cos tidyverse funcns like purrr expect them unquoted duh-huh! 

col_pick_env <- function(a_col){
  stranded_data |>
    select(.env[[a_col]])
  
}
col_pick_env("age")


# supply a column name
# select that column
# rename to new_ something

tidy_rename_mask_fun <- function(the_col_name){
  the_tidy_result <- stranded_data |>
    select(new_the_col = {{the_col_name}})
  return(the_tidy_result)
}
tidy_rename_mask_fun(age)
# you can rename to a fixed name fine
# but if you want to dynamically splice into the name, more complicated. 
# use := 

tidy_dynamic_mask_fun <- function(the_col_name){
  the_tidy_result <- stranded_data |>
    select("new_{{the_col_name}}" := {{the_col_name}})
  return(the_tidy_result)
}
tidy_dynamic_mask_fun(age)
# tibbles are stricter about names you're allowed
# the := makes some of those checks happen later
# so you temporrily bypass them
# and so sometimes just popping in the colon is a good way to see if you can fix a problem. 
# double curly brackets can be a bit like glue
# to, in this case, rename in place and select


