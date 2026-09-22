# Examples inspired from
# The Art of Programming in R - Matloff

library("tidyverse")

source("code_wt_health_data_egs/data_structures.R")

# Ch2 Vectors
hosps_vec <- hosp_lookup$hospital_official_name
is.vector(hosps_vec) # TRUE

## any and all

# Confirm whether any names contain ampersand '&'
str_detect(hosps_vec, "&") # vector of logicals
any(str_detect(hosps_vec, "&")) # one logical
# Confirm whether all names contain ampersand
all(str_detect(hosps_vec, "&")) # one logical
