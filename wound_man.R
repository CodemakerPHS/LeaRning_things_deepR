# base R ----
# Do mouseover the red circles in the margin for *not* a preview 
# but extra debugging detail complementary to the error messages

# doing a bit of complicated arithmetic
# broken
3 * (2 + 2 + (8 - (1+(4.2 - 1.3)^3.4) + 1)

     # try
     3 * (2 + 2 + (8 - (1+((4.2 - 1.3)^3.4)) + 1))
          
          
     # add up 1 to 3
     SUM(1,2,3)
     SUM(c(1,2,3))
     sum(1,22,33)
     
     # averaging 1 to 4
     mean(1::4)
     mean(1:4)
     
     # creating and show a variable containing the number 3
     my_n < - 3
     my_n <- 8
     my_N 
     
     # making a sequence from 1 to my_n-1
     1:my_n-1 # Starts at zero argh!
     # should hv brackets
     # The below is clear whereas the above deducts 1 from both the start and end of the range. 
     1:(my_n - 1)
     
     names <- c(names, NA)
     
     # making a vector of numbers, and adding two to the first two items
     my_ vec <- c(2, 3, "two")
     my_vectr <- c(2, 3, "two") # Look out, this creates chr vector! 
     my_vectr <- my_vectr[1:2]
     my_vectr <- as.numeric(my_vectr[1:2])
     my_vectr + 20 
     # should be
     good_vec <- c(8L,33L, 2L)
     good_vec <- good_vec[1:2]
     good_vec <- c(good_vec, 200L)
     
     # multiplying two vectors together
     my_vec <- as_numeric(my_vectr)
     My_vec2 <- c(2,5,4,)
     my_vec * my_vec2
     
     # checking that an item in a sequence equals a particular value
     .2 == .2
     seq(0, 1, by=0.1)[2] 
     # See above - unlike other langs, vectors in R start at 1 not 0. 
     # So to compare 0.2 to 0.2, see below - gives TRUE where expected in fact.
     seq(0, 1, by=0.1)[2] == 0.2
     wee_seq <- seq(0, 1.9, by = 0.1) 
     wee_seq
     wee_seq[3]
     wee_seq[3] == 0.2
     seq(0, 1, by=0.1)[3] == 0.2
     
     rm(my_n)
     
     # creating a vector of three names
     boring_names <- C("Steve", "Emma, Bob")
     # Watch out, only two elements!
     boring_names <- c("Steve", "Emma, Bob")
     # trying to find if names contains "Steve"
     if(boring_names == "Steve") "Steve's here!" 
     if("Stern" %in% boring_names) "contains is nice."
     if("Ste" %in% boring_names) {
             "contains is nice."
     }
     if("*Bob*" %in% boring_names) {
             print("%in% is useful and nice.")
     }
     if("Steve" %in% boring_names) {
             print("%in% is useful and nice.")
     }
     # Instead of %in%, use "any"
     if( any (boring_names == "Steve")){
         "Also, any can be quite handy too."    
     }
     # trying to find if names contains "Steve" and/or "Emma"
     if(names == c("Emma", "Steve")) "It's the usual suspects"
     
     # repeat the names object my_n times
     rep(names, my_n)
     
     # these should all give the same results, right...
     iris[,"Species"]
     iris["Species"]
     iris[[,"Species"]]
     iris[["Species"]]
     
     # I'd like to find out if the names object has any NAs
     names == NA 
     
     # to try and find out if names does not contain 3 items
     length(names != 3) 
     
     # there's nothing wrong with the function definition, but there is something wrong with the function call...
     checko <- function(vec, to_lower){
       if(to_lower){
         vec <- tolower(vec)
       }
       
       if(any(vec %in% c("emma", "steve"))) {
         "The usual suspects are here again"
       } else {
         "No sign"
       }
     }
     
     checko(names,,TRUE)
     
     # loop over 1:3 and print the number  
     for(index %in% 1:3) {print(index)}
     
     # why doesn't this give a rounded cumulative mean?
     c(6,5,7,4) |>
       cumsum() |>
       mean()
     round()
     
     # tidyverse ----
     
     library(reader)
     llbrary(stringr)
     
     
     
     
     # does this data load correctly?
     botw <- read_csv("https://nes-dew.github.io/KIND-community-standards/data/KIND_book_of_the_week.csv")
     
     # find books recommended after June
     botw |>
       filter(Date < "2024-06-01") 
     
     # can you find any author names with brackets
     brackety_authors <- botw |>
       filter(str_detect(Author, "("))
     
     # find books with more than one author
     multi_authors <- botw |>
       filter(stringi::str_detect(author, " and "))
     
     # how many books had multiple authors
     length(multi_authors)
     
     # plot the publication year by date
     library(ggplot)
     library(Dplyr)
     
     bOtw |>
       ggplot2() +
       + geom_line(aes(x = Date, y = year)) 
     + ggtitle("A nice time-series plot of year against date") 
     + theme_minimal