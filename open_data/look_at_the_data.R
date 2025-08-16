# Just looking at datasets

# datasets::esoph, 88 obs of 5 varbls
oesophageal_baser_eg <- datasets::esoph

# datasets::fdeaths
# Not cancer
# Bronchitis, emphysema and asthma
# [Monthly!] Time-Series [1:72] from 1974 to 1980: 901 689 827 677 522 
# six yrs * 12 mths appears to hold 72 values
UK_deaths_lung_female <- datasets::fdeaths

# See also potentially interesting: 
# HairEyeColor
# Harman
# indometh
# infert


# v 0.3.0 of NHSRdatasets
library(NHSRdatasets) 
# > install.packages("NHSRdatasets")

# opendata.nhs.scot cancer incidence API query by SQL statement
https://www.opendata.nhs.scot/api/3/action/datastore_search_sql?sql=SELECT * from "72c852b8-ee28-4fd8-84a9-5f415f4bc325" WHERE title LIKE 'jones' 

# opendata cancer mortality API
# results containing 'jones'
https://www.opendata.nhs.scot/api/3/action/datastore_search?q=jones&resource_id=ba8d7049-ec05-4291-9333-57ca49ce7697 

# opendata nhs cancer incidence, complete CSV
library(tidyverse)
incdence_by_RCN <- read_csv("https://www.opendata.nhs.scot/dataset/c2c59eb1-3aff-48d2-9e9c-60ca8605431d/resource/8cba0250-7e78-496d-8559-98c9c9a3d3e3/download/opendata_inc9822_region.csv")
colorectal_inc <- incdence_by_RCN |> 
  filter(str_detect(CancerSite, regex("colorec", ignore_case = TRUE)))

