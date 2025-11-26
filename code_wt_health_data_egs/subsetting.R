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
# Use a named vector to assign names to values, and use to retrieve data

network_lookup <- c(NCA = "North Cancer Alliance", 
                    SCAN = "South East Scotland Cancer Network", 
                    WoSCAN = "West of Scotland Cancer Network", 
                    S = "Scotland")
network_lookup["SCAN"]

one_network <- "WoSCAN" # Get the case correct, otherwise it breaks!
network_lookup[one_network]

# Lookup file with hospitals, codes and health boards, not kept up-to-date
# Build a lookup not a tibble for direct access, to avoid pipe and filter
# Store hospital long names in a vector
hosp_codes_lookup_vec <- hosp_lookup[["hospital_official_name"]] 
# Use setNames() to set the corresponding five-character codes as 'keys' 
# ie key-value pairs
hosp_codes_lookup_vec <- setNames(hosp_codes_lookup_vec, hosp_lookup[["Hospital_code"]])

# Feed the variable containing a short hospital code into the lookup, 
# and it returns the full hospital name
one_hosp <- "D102H"
hosp_codes_lookup_vec[one_hosp]

# Different example
hosp2 <- "L302H"
# Use unname() to return just the answer, not the key-value pair
unname(hosp_codes_lookup_vec[hosp2])

# DO NOT EXPECT THE BELOW TO WORK
hosp3 <- "X1010"
hosp_codes_lookup_vec[hosp3] 
# My list did not define missing values.
# X1010 "Not applicable"

# Pass in a vector of codes, get back a vector of the results, with short codes.
a_few_hosps <- c(one_hosp, hosp2, hosp3)
hosp_codes_lookup_vec[a_few_hosps]

# Book example in 4.5.1
x <- c("D102H", "X9999", "L302H", "X1010", "L302H", "L302H") 
lookup <- c(D102H = "Golden Jubilee", 
            L302H = "Hairmyres, Lanarkshire", 
            X1010 = "Not applicable", 
            X9999 = "Not recorded")
lookup[x]
unname(lookup[x])
