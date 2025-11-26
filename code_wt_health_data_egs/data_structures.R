############
#
# Pauline July 2025
# Cheat Sheet for R data structures
#
# Before going further,
# using positron handy auth integrn for github so far so good.
# Else if (using posit cloud){
#  might need to wrangle github personal access token apparently
# https://docs.posit.co/cloud/guide/advanced/index.html#working-with-github
# }
# ###########

library(here)
library(tidyverse)

data_dir_path <- here("open_data")

# Example data - Quality Performance Indicators
# Provided by PHS under the Open Govt Licence
# Warning: read_csv is just reading in all cols guessed as character type
# when in fact some are numeric and some should be factors.
# Tibble with duplicate column names
testis_QPIs_2020_2023 <- read_csv(here(
  data_dir_path,
  "2024_12_10_testis_qpi_summary_table.csv"
))

# Example data - cancer incidence, bladder
incidence_by_RCN <- read_csv("https://www.opendata.nhs.scot/dataset/c2c59eb1-3aff-48d2-9e9c-60ca8605431d/resource/8cba0250-7e78-496d-8559-98c9c9a3d3e3/download/opendata_inc9822_region.csv") 
bladder_inc <- incidence_by_RCN |>
  filter(str_detect(CancerSite, regex("bladder", ignore_case = TRUE)))

# My wee reference file with table of hospitals, codes and health boards, not kept up-to-date
# Latest official equivalent version at: 
# https://www.opendata.nhs.scot/dataset/hospital-codes 
# ... but does not have the full hospital names etc, you have to look them up!
hosp_lookup <- read_csv(here(data_dir_path, "hosp_codes_and_HBs.csv")) 


         