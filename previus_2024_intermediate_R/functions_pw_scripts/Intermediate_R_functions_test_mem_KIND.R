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

simple_func <- function(number_arg = 4) {
  
    important_num <- 42 * number_arg
  
  
} 

odd_num = 7

if (odd_num %% 2 == 0) {
  print("Even!!!")
} else {
  print("nope not even")
}

simple_func("a test") 
simple_func(7)
simple_func("100") 

ifelse(odd_num %% 2 == 0, output = "this is even", output = "an odd number") 

# The curly brackets approach oldfashioned if and then else is readable. 
# So is nice for more complex things, esp with plots. 
# Whereas ifelse() and switch are vectorised. 
# So you could pass in a c(,,,,,) multiple values and get all outputs at once.
# ?switch 
# switch() is a faff, and the help is rubbish. Lets you do a case sttmt. 
switch ("C", etc?????????? 
  case = action
)


# Brendan - the three dots, as seen in the docs for switch, let you pass arguments in a certain way. 
# specifies args as a list. Meaning we can change the args to the inner function
# and not have to re-write the outer function, cos using the three dots 
# tells R to pass through the rest of the args. 
# as in Brendan's funcn for checking if divisible by three 

# Code below - if we decide to do something else in is_even etc 

is_even <- function(n){
  ifelse(n %% 2 == 0, "I am even", "I am odd")
}
is_three <- function(n2, ...){
  if(n2 %% 3 == 0){
    # runs when true
    three_out <- "Is divisible by three"
  } else{
    # this code runs
    three_out <- "Is not divisible by three"
  }
  two_out <- is_even(...)
  c(three_out, two_out)
}
is_three(331, 151)
# Whether it's one arg or twenty that you're passing to the inner function, 
# the three dots will pass them all. 