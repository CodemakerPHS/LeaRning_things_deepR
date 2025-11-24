#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 
# Subsetting 
# Adapted from chapter 4 of Advanced R 
# For the CASES R Book Club November 2025
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

source("code_wt_health_data_egs/data_structures.R")

# Simple vector
# Regional cancer networks in alphabetical order, plus Scotland
locations <- c("NCA", "SCAN", "WoSCAN", "Scotland")

# You can use six things to subset a vector
## Positive integers. Remember, indexing starts at 1, not at zero.
locations[c(3,1)]

## Use order() to sort in alphabetical/numerical order - Horrible!
locations[order(locations, decreasing = TRUE)]

## Using duplicate indices does work
locations[c(1,1,1)]

## Negative integers - to EXCLUDE elements at the given indices 
locations[-c(1,4)]

## ... but no mixing positive and negative. 
locations[c(3,-4)] # Error
locations[0] # zero-length chr vector

## Logical vectors
QPI_names <- as.vector(testis_QPIs_2020_2023[["QPI"]])
QPI_names[c(FALSE, FALSE, FALSE, TRUE)] # Why does this return two strings?! Answer below.

bladder_crude_rate <- as.vector(bladder_inc[["CrudeRate"]])
bladder_crude_rate[0] # zero-length numeric vector
# The two lines below produce identical output, because it repeats ie recycling. 
# Not recommended. 
bladder_crude_rate[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)]
bladder_crude_rate[c(TRUE, FALSE)] 

# Make a shorter vector for convenience
bladder_crude <- bladder_crude_rate[1:10]
bladder_crude
bladder_crude > 14
bladder_crude[bladder_crude > 14]

# Setting names ie make a named vector
bladder_lookup <- setNames(bladder_crude[1:4], locations[1:4])
bladder_lookup["WoSCAN"] # works a bit like a Perl hashtable
one_network <- "WoSCAN"
bladder_lookup[one_network] # replace the literal string with a variable
# For some applications, the above is a less error-prone way of accessing data.
# Because it is unaffected, if the order of the elements in the vector changes.


# 4.5.1 Lookup tables ##### 

network_lookup <- c(NCA = "North Cancer Alliance", 
                    SCAN = "South East Scotland Cancer Network", 
                    WoSCAN = "West of Scotland Cancer Network", 
                    S = "Scotland")
network_lookup["SCAN"]

one_network <- "WoSCAN" # Get the case correct, otherwise it breaks!
network_lookup[one_network]

hosp_lookup <- read_csv("table_of_hosp_codes.csv")