#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# RStudio Workbench is strictly for use by Public Health Scotland staff and     
# authorised users only, and is governed by the Acceptable Usage Policy https://github.com/Public-Health-Scotland/R-Resources/blob/master/posit_workbench_acceptable_use_policy.md.
#
# This is a shared resource and is hosted on a pay-as-you-go cloud computing
# platform.  Your usage will incur direct financial cost to Public Health
# Scotland.  As such, please ensure
#
#   1. that this session is appropriately sized with the minimum number of CPUs
#      and memory required for the size and scale of your analysis;
#   2. the code you write in this script is optimal and only writes out the
#      data required, nothing more.
#   3. you close this session when not in use; idle sessions still cost PHS
#      money!
#
# For further guidance, please see https://github.com/Public-Health-Scotland/R-Resources/blob/master/posit_workbench_best_practice_with_r.md.
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


library(tidyverse)
library(purrr)

# following the purrr course 

# Brendan likes the list data type. You can have different types, so a bit like a vector
# but unlike the vector you can have diff types. 

# lists were a special kind of vector, but have become quite different. 
vector("list", 10)
list()
# whereas lst() is a bit more tibble-ish, is the tidyverse version
lst()
polo_list <- list(a=1:10,
                  b = 10:1
  
) # base aka listy
# error if try to use a list in a vectorised way cos is a list not a vector. 
# the $ annotation from base R does work
polo_list * 10 
polo_list$a 
polo_list[[a]] # not ok 
polo_list[["a"]] # ok 
polo_list["a"] # ok

# purrr helps you work with lists, makes it easy 

polo_list |> 
  pluck("a")

polo_list |> 
  pluck(1)

# a tibble is just a special kind of list . 
# pluck is handy. 
polo_list |> 
  pluck(2,3)

# error if put a range into pluck, doesn't work
# funcn to multiply by 10 

deci <- function(n){
  n * 10
}
# modify lets you take a list and function and apply one to the other. 

modify(polo_list, ~. * 10) # use the tilde'd full stop to apply over all elts 
# but is anonymous, not very nice, would be nicer to define a named funcn. 

list_c(polo_list) # coerce the list back to a vector, show all elts
list_flatten(polo_list)
# returns the same object. But we can make lists that contain lists. 
# and use flatten on them. 

polo_list <- list(z = polo_list,
                  y = polo_list)
list_flatten(polo_list)
polo_list$d |> 
  assign_in("d", letters[10:1]) # cannot see this?!?!
# BECAUSE I DIDN'T ASSIGN IT BACK TO POLO_LIST HAHA! 
polo_list$p <- c(LETTERS[12:26])

list_flatten(polo_list)

# what if we want to multiply all numerics by 10, but don't want the error 
# we'll get because of letters in some elts? 
modify_if(polo_list, is.numeric, )

# On the purr cheat sheet, keep in mind, the green squares with the bubble 
# around em is a list 
# while the blue ones without a wall are lists. 
# and the other ones are tibbles. 
# eg modify takes a list and returns a list
# whereas pluck returns just a one-elt vector. 
# and list_c() takes a list (has a cell wall), and returns a vector (no cell wall in the visual)

polo_list <- polo_list |> 
  assign_in("d", letters[10:1]) # assigns to d, but doesn't persist in polo_list 
list_flatten(polo_list)
assign_in("d", LETTERS[1:3]) # nope
polo_list <- assign_in(polo_list, "true", letters[26:24])
list_flatten(polo_list)

