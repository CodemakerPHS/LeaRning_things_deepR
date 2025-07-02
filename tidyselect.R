#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# tidyselect course with Brendan
# Pauline 2 July 2025
#  
# Using NHSRdatasets
# https://nhs-r-community.github.io/NHSRdatasets/
# 
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

library(NHSRdatasets) # for sample data
library(dplyr)

glimpse(stranded_data)


2:8

# Use column indexes, remember starts from 1
stranded_data %>%
  select(2:5) 

stranded_data %>%
  select(age:hcop)


View(stranded_data)

stranded_data |>
  select(periods_of_previous_care)
# return a one-col tibble

stranded_data |>
   names()

#NB will fetch all of these, but not repeat
stranded_data|>
  select(hcop, age, admit_date, age)

# In Base R usu use unquoted names. See course  how to selec cols as if objects. 
# in the tidy EVALUATION session

stranded_data %>%
  select(!stranded.label, !admit_date, !frailty_index) 

stranded_data %>%
  select(!c(stranded.label, admit_date, frailty_index)) 

stran |>
  select(contains("care"))
# not a nearest neighbour match
# returns them in order 

stran |>
  select(contains("care"))
# not a nearest neighbour match
# returns them in order

# !!! NOT case sensitive!!
stran |>
  select(contains("CARE"))

sessionInfo() # dplyr 1.1.4
# care OR a full stop 
stran |>
  select(contains("care"), contains(".")) 
# evals left to right within 

# same
stran |>
  select(c(contains("care"), contains("."))) 

# While the below is equivalent, is slightly less readable
stran |>
  select(contains(c("care", ".")))

# ... and is same as "|" the OR operator



stranded_data |> 
  select(contains(c(".", "care")), age)
# Adds on age col at end 

# ONly has care AND full stop 
# use operators to do and

# So this is morerestrictive just one col, it's the inner join so to speak
stran |>
  select(contains("care") & contains("."))

# negate with a minus
stran |>
  select(contains("care") & -contains("."))

# exactly same: ! WORKS same as minus -contains
stran |>
  select(contains("care") & !contains("."))

stranded_data %>%
  select(starts_with("m") & ends_with("e")) 

stranded_data %>%
  select(starts_with("m") | ends_with("e")) 


# num_range() matches columns with numeric ranges. For example, in the billboard 
# dataset, there are a large number of columns named wk1, wk2… representing weeks. To select wk10 to wk15:
# Unusual to use this.   
tidyr::billboard
  tidyr::billboard |> 
  dplyr::select(num_range("wk", 10:15))

# .. in practice, you might pivot longer then filter
  # You can reverse order. 
  tidyr::billboard |> 
    dplyr::select(num_range("wk", 10:5))
  
  # MATCHES ----
  
  stran |>
    select(matches("CARe"))

  waldo::compare  (
  stran |>
    select(matches("CARe")) ,
  stran |>
    select(contains(c("care", "."))
  
    
  # IN MATCHES, THE FULL STOP IS A WILDCARD
  # matches lets you use regext o find columnsn
  
  # probly not worth using grep
  grep("s", c("string", "ning"))
  
  # but idiomatically is annoyng while tidyverse nicer. 
  
  # Do use regex101.com but be aware 
  # ANY STUFF THAT HAS A BACKLSASH, FOR R YOU NEED A DOUBLE BACKSLASH. to escape. 
  
  # where ----
  # where takes a function name 
  # and returns all the cols where that funcn returns true
  stran |>
    select(where(is.numeric))
  
  # not working
#  stran |>
 #   which(is.numeric)
  
  
  my_col_names <- c("one_nice_col", "age", "hcop", "fourth")
  
  stran |>
    select(all_of(my_col_names))
  
  stran |>
    select(any_of(my_col_names))
  
  # probably use for dropying any of patsname patfname
  
  
  # use everything() with pivot_longer() to make sure you've got everything
  
  select(everything()) # pointless
  
  
  # any of v useful for dropping cols, only if they are there, v safe way to do it.
  stran |>
    select(-age) |>
    select(-any_of("fourth", "admit_date"))
  
  # https://nes-dew.github.io/KIND-training/r_training/tidyselect.html#if_any-if_all-across-and-pick
  
  # For the following need to expand these, go back to the materials. 
  
  # broken
    stran |>
      filter(if_any(contains("care", ~ .x == 1)))
    
    # across
    stran |>
      mutate(across(where(is.character), toupper))
    
    # pick lets you do a select but return a tibble you can pass into another function
    # multiselect, so is a bit like doing a distinct first then 
    stran |> 
      