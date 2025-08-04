#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Collating cancer-based examples corresponding to
#  the statistical methods and illustrations given in CaAS team training on
# statistical awareness by Prof Chris Robertson Feb and March 2025 CASES talks. 
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

library(phsopendata)
library(phslookups)
library(tidyverse)

# Current hosp mortality
# resource_id=bbd2d05c-4bf0-4d73-95af-14520562ac51 

mortality_smr_df <- get_resource(res_id = "bbd2d05c-4bf0-4d73-95af-14520562ac51")
# above is 16 obs , 10 cols
# includes the expected no. of deaths, observed number, SMR and crude rate.

head(mortality_smr_df)

# Join to add health board names! Check for latest changes at: 
# https://www.opendata.nhs.scot/dataset/geography-codes-and-labels 
# not any internal resource, since data is public

hb_names_url <- "https://www.opendata.nhs.scot/dataset/9f942fdb-e59e-44f5-b534-d6e17229cc7b/resource/652ff726-e676-4a20-abda-435b98dd7bdc/download/hb14_hb19.csv"
hb_names_df <- read_csv(hb_names_url)

mortality_smr_df <- mortality_smr_df |> 
  left_join(y = hb_names_df, by = c(HB == HBT))
  