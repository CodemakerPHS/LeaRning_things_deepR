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
  