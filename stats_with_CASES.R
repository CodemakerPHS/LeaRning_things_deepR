#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Collating cancer-based examples corresponding to
#  the statistical methods and illustrations given in CaAS team training on
# statistical awareness by Prof Chris Robertson Feb and March 2025 CASES talks. 
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

library(phsopendata)
library(phslookups)

# Current hosp mortality
# resource_id=bbd2d05c-4bf0-4d73-95af-14520562ac51 

mortality_smr_df <- get_resource(res_id = "bbd2d05c-4bf0-4d73-95af-14520562ac51")
# above is 16 obs , 10 cols
# includes the expected no. of deaths, observed number, SMR and crude rate.

#mortality_smr_df <- mortality_smr_df |>
  