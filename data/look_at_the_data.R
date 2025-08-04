# Just looking at datasets

# datasets::esoph, 88 obs of 5 varbls
oesophageal_baser_eg <- datasets::esoph

# datasets::fdeaths
# Not cancer
# Bronchitis, emphysema and asthma
# [Monthly!] Time-Series [1:72] from 1974 to 1980: 901 689 827 677 522 
# six yrs * 12 mths appearsto hold 72 values
UK_deaths_lung_female <- datasets::fdeaths

# See also potentially interesting
# HairEyeColor
# Harman
# indometh
# infert


# v 0.3.0 of NHSRdatasets
library(NHSRdatasets) 
# > install.packages("NHSRdatasets")
# Installing package into ‘/mnt/homes/pauliw07/R/x86_64-pc-linux-gnu-library/4.4’
# (as ‘lib’ is unspecified)
# Warning in install.packages :
#   unable to access index for repository https://ppm-prod.publichealthscotland.org/phs-github/__linux__/jammy/latest/src/contrib:
#   cannot open URL 'https://ppm-prod.publichealthscotland.org/phs-github/__linux__/jammy/latest/src/contrib/PACKAGES'
# trying URL 'https://ppm-prod.publichealthscotland.org/cran/__linux__/jammy/latest/src/contrib/NHSRdatasets_0.3.0.tar.gz'
# Content type 'application/x-gzip' length 296116 bytes (289 KB)
# ==================================================
#   downloaded 289 KB
# 
# * installing *binary* package ‘NHSRdatasets’ ...
# * DONE (NHSRdatasets)
# 
# The downloaded source packages are in
# ‘/tmp/Rtmp5f82Ie/downloaded_packages’

# opendata.nhs.scot cancer incidence API query by SQL statement
https://www.opendata.nhs.scot/api/3/action/datastore_search_sql?sql=SELECT * from "72c852b8-ee28-4fd8-84a9-5f415f4bc325" WHERE title LIKE 'jones' 

# opendata cancer mortality API
# results containing 'jones'
https://www.opendata.nhs.scot/api/3/action/datastore_search?q=jones&resource_id=ba8d7049-ec05-4291-9333-57ca49ce7697 
S