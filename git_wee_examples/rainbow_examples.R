# Rainbow examples from Learning Git
# Adapted by Pauline

library("tidyverse")

# Import population estimates for Scotland's Data Zones
# 460,482 rows
dz_popn_df <- read_csv(
  "https://www.opendata.nhs.scot/dataset/7f010430-6ce1-4813-b25c-f7f335bdc4dc/resource/c505f490-c201-44bd-abd1-1bd7a64285ee/download/dz2011-pop-est_21112024.csv"
)
