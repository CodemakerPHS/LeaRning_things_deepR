############
# 
# Pauline July 2025
# Cheat Sheet for R data structures
# 
# Before going further, need to wrangle github personal access token apparently 
# https://docs.posit.co/cloud/guide/advanced/index.html#working-with-github 
# ###########

library(here)
library(tidyverse)

# Working dir is /code_wt_health_examples
# Data dir is ../data
data_dir_path <- "data"

# Everything is an object. 

# Example data - Quality Performance Indicators 
# Provided by PHS under the Open Govt Licence 
# Warning: read_csv is just reading in all cols guessed as character type
# when in fact some are numeric and some should be factors. 
testis_QPIs_2020_2023 <- read_csv(here(data_dir_path, "2024_12_10_testis_qpi_summary_table.csv"))

