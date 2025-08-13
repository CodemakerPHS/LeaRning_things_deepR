# data.table
# DO NOT LOAD TIDYVERSE COS WE'RE GONNA PLAY WITH DATA FRAMES

library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(here)
library(data.table)
library(microbenchmark)


#> getwd()
#[1] "/conf/quality_indicators/Benchmarking/Cancer_QPIs/Data/pauline_code/leaRRRning_things"
#/data

local_path <- "r_training/data/flights14.csv"
local_path <- "/conf/quality_indicators/Benchmarking/Cancer_QPIs/Data/pauline_code/leaRRRning_things/data/flights14.csv"



mtcars

mtcars$mpg
mtcars[1]
# error
mtcars[mpg]
mtcars["mpg"]

mtcars[["mpg"]]
# The above is returning a vector instead of a data frame. 
# In tidyverse the idiom would be pull(). 
# And dollar sign is equivalent to that. 

# Subset by index"
mtcars[1,]  # it's row 1
mtcars[,1]  # column 1
# think about 
mtcars[1,1] # one cell in the table so-to-speak

mtcars[3,8][1] # get back a data frame, by chaining the single brackets together. 
mtcars[3,8][2] # error

# in_dat <- here("data") # not working

# We' l  make mtcars into a data.table
data.table(mtcars)
