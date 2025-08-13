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


# setup ----
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

# We' l  make mtcars data frame into a data.table
data.table(mtcars)
# it can also take a tibble, but no need to convert mtcars df to a tibble :-)

mtc <- mtcars
class(mtc) # data.frame , still
setDT(mtc)
class(mtc)
# So, unusually for R, it is changing in place, modifying in place. 
# That is an efficincy - avoid duplicating the thing, by just modif in place. 

# subsetting ----
mtc
# mtc[row, col/calculate, group] # this is roughly how the syntax works
# dt[i,j,by]
mtc[1] # still works, but NOW first ROW
mtc[,1] #  FIRST COLUMN
# So looks similar, but has transposed rows and columns argh!!!!!!!!!!!!!!

# And chaining still works
mtc[,3][1]
# try by name
mtc["mpg"] # ERROR!
mtc[,"mpg"] # this is it

