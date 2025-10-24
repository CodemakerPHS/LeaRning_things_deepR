#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 
# Subsetting 
# Adapted from chapter 4 of Advanced R 
# For the CASES Book Club November 2025
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Simple vector

locations <- c("NCA", "SCAN", "WoSCAN", "Scotland")

# You can use six things to subset a vector
## Positive integers. Remember, indexing starts at 1, not at zero.
locations[c(3,1)]

## Horrible! - Use order() to sort in alphabetical/numerical order
locations[order(locations, decreasing = TRUE)]

## Using duplicate indices does work
locations[c(1,1,1)]

## Negative integers - to EXCLUDE elements at the given indices 
locations[-c(1,4)]

## ... but no mixing positive and negative. 
locations[c(3,-4)] # Error

## Logical vectors
