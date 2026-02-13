#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 
# Subsetting 
# Adapted from chapter 6 of Advanced R https://adv-r.hadley.nz/functions.html 
# For the CASES R Book Club April 2026
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

source("code_wt_health_data_egs/data_structures.R")

# Section 6.2.1, on function components, is interesting, potentially useful. 

f02 <- function(x, y) {
  # A comment
  x + y
}

formals(f02)
#> $x
#> 
#> 
#> $y

body(f02)
#> {
#>     x + y
#> }

environment(f02)
#> <environment: R_GlobalEnv> 

attr(f02, "srcref")
#> NULL

# Not going to use a dplyr example because there's a new version 
# with handy new functions. 

library(janitor)
attr(round_half_up, "srcref") 
# Oops - NULL - which tells us this function might be implemented in C. 