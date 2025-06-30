# NES Debugging course 30 June 2025
# 

library(tidyverse)


# non-numeric arg to binary operator - opaque. some tidyverse error msgs are better
#c("hello", "world") * 2

# works ok: 
c(2,3,4)*3

# Behaviour of the following has changed, cos of changes in base R
#c(2,3,4) * c(3,4) # gives yu a warning
c(2,3,4) * c(3,4,9)
# R has vector recycling rules. So it does not behave v predictably. 
# These operations have to run up against length one, or length the same as other arg. 
# Tibbles more permissive. 

# Using breakpoint browser
n <- 7

add_one <-  function(n){
 n <- n + 1 
}
# That value is never accessible in the global env cos is in the function. 
# So this'll not give unexpected results. 
# But may be have in weird or unexpecd way, 
# usu just break it down. 
# But breakpoint browser lets you explore . 
# Click in left hand margin . 
add_one(1)
add_one(9)