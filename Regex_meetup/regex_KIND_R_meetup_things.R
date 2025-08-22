# KIND R Meetup on Regex 
# Brendan Clarke 24 April 2024 with Andrew Saul 



library(pacman)
library(tidyverse)


# Resources # ----
## Regex 101 ##
# Top tip: use https://regex101.com/ 
# ... to build and test regexs 
# nice training wheels 

# Brendan using PCRE2 / PHP>7.3 flavour ROUGHLY CLOSEST TO R

# TO BRING TO R, YOU HAVE TO DOUBLE UP THE SLASHES \\ // 
# SOMETHING TO DO WITH THE COMPILER

## Cheat sheet Dave Child ##
# https://cheatography.com/davechild/cheat-sheets/regular-expressions/

# Testing things # ----
# Another tip: try your expression on a vector before putting it in mutate()  
# to apply it to a tibble


# ANCHORS # ----
# ^ start of line 
# $ anchor to the end of something, useful in matching names 

# Wildcards aka Match Characters ----
# What I like to call 'Wildcards' (Posit call these Match Characters yuck)

# . is ANY AND EVERY CHARACTER except a new line; 

# \d digit; 
# \D non-digit
# \w word character
# \W non-word characters
# \b word boundary = whitespace or line break \b

# Quantifiers # ----
# ? is 0 or 1; 
# * is 0 or more; 
# + is 1 or more; 
# {n} where n is the number of instances






my_string <- "QPI 6(ii) TURBT trans urethral resection of a bladder tumour"
my_stringy_vector <- c("90%", "QPI 3(i)", 'measurability', "Regional networks: mapping")
?str_detect

str_detect(my_string, "r$") # TRUE
str_detect(my_string, "p$") # FALSE
str_extract(my_string, "r$") # returns 'r'
str_extract_all(my_string, "r$") # returns 'r' 

str_extract_all(my_stringy_vector, "t")

# Haven't mentioned capture groups yet but I'd pretty much always use them!

# str_extract(string, pattern, group = x)

# ie when you match something, be able to extract the surrounding text
# so match part of it but return more 

# in str_extract_all there's no group option! 

# escaping: In R its because the regex is inside a string, so need two escapes 
# str_extract is the first match and str_extract_all is all matches 

# PHS used to have a postcode for people who didn't have a postcode: NK01 0AA 
# There was another one NF1 1AB . I remember years ago working on a project that involved both. 
# PW - Sounds like abbrev for Not Known and Not Found, respectively. 
# Still used by other boards, see these every day in SAS incidents we get sent

# eg postcode 
# 

my_postcode_list <- c("EH99 1SP", "EH12 9EB", "NK01 0AA", "G26 7RA")

str_extract(my_postcode_list, "^N")
str_match(my_postcode_list, "\\d")  # just \d generates an error 

# p208 of R for Data Science has a brilliant example for validating an email address 
 
# ctrl + alt to duplicate a line 
# crowd-sourced on regex101.com: 
# \D{1,2}\d{1,2}\D?\s{0,2}\d{1}\w{2}\s?$

# g697sj
# EH1  2lP
# EH35UD
# SW1X9at
# G348jp
# sw179et

# EC3P 3DQ

# Ab247gh

# NK01 0AA 
# https://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom#Formatting
# EC3P 3DQ