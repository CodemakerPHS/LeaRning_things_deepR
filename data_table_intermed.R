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

