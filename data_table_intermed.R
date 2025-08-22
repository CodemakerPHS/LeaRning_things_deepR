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

# Subset by index
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
# So looks similar. 

# And chaining still works
mtc[,3][1]
# try by name
mtc["mpg"] # ERROR!
mtc[,"mpg"] # this is it

# You can put in unquoted col names as if objects, by wrapping em in a list. 
# or special data table shorthand full stop bracket

mtc[, c("mpg", "hp")] # ok
mtc[, list(mpg, hp)] # ok
mtc[, .(mpg, hp)] # also works, but not v readable

# filter
mtc[mpg > 30 & hp < 100]
mtc[mpg > 30 | hp < 100] 
mtc[mpg > 30][hp < 100][,.(cyl)] # do a filter, do another filter, then just get the cyl col
mtc[mpg > 30][hp < 100][,"cyl"] # equivalent
mtc[mpg > 30][hp < 100,.(cyl)] # equivalent
# Can be v concise. 

# If you give it an unquoted column name, data.table will turn it into a vector. 
mtc[,hp]

# Joy example
mtc[mpg >30][,cyl]
mtc[mpg>30][,.(cyl)] 

# It handles non-numeric data OK too . 

# .( is always the shorthand for a list
# .N is equive to count the rows in each group 

# a calculation ----
# rename it as well, just within, cos it throws away the col name
# So this is how to change cols, equiv to mutate
mtc[, .(thing = hp * cyl)]
mtc[, .(pw_col = hp * 2, wt, drat)]

mtc[, .(new_hp = hp * 2, wt, drat, hp)] # this works

# .N using dot N ----
# is simple to group
mtc[, .(count_duckula = .N), by = cyl]
mtc[, .(count_duckula = .N), by = cyl][order(cyl)]

# add a summing calcn

mtc[, .(some_horse = sum(hp)), by = cyl][order(cyl)]

mtc[, .(mean_horse = mean(hp)), by = cyl][order(cyl)]

# Have a look at dtplyr
# https://dtplyr.tidyverse.org/ 
# it is for data.table. 

# Not mtc[,hp] > head(20)
# do mtc[,hp] |> head(20)

# Now use fread (like 'freed' to rhyme with heed]
# https://github.com/arunsrinivasan/flights/wiki/NYCflights14/flights14.csv 

flights_link <- "https://github.com/arunsrinivasan/flights/wiki/NYCflights14/flights14.csv"
pwflights <- fread(flights_link)
pwflights |>
  class()

