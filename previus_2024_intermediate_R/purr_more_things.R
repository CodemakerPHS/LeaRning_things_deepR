# purr some more examples with brendan clarke 

library(purrr)
library(NHSRdatasets)
library(tidyverse)

# ae_attendances is v good for purr 
ae_attendances
sum_attendance_func <- function(org){
  ae_attendances |> 
    filter(org_code == {{org}}) |> 
    summarise(sum = sum(attendances))
}
sum_attendance_func("RF4")

# how do we use this to make nice summary stats for a bunch of orgs? 
unique((ae_attendances$org_code))
sample(unique(ae_attendances$org_code), 10)

# map() takes two args, x which is a vector, and then a function 
# .. a function that we're going to apply. 
# and captures it as a list...? 

some_att <- function(org){
  ae_attendances |>
    filter(org_code == {{org}}) |>
    summarise(sum = sum(attendances)) |>
    pull(sum)
}
orgs <- sample(unique(ae_attendances$org_code), 10)

map(orgs, some_att)
some_att("RQM")
map(orgs, some_att)

# use pmap() for funcns that take more than one arg. 
# use walk to see when you'r interested in the side effect eg for plots 
# when we're only interested in the plot. 

# tom question - should we use this to coerce funcn output? 
# brendan - yes - it's nice tidyverse meta approach 
# to give you a choice of how much you want it to be complainy? 
# so lets you check you're doing the right thing in your function? 
# all is do-able in base R, but this makes it easier. 
#eg map_lgl() lets you force it to return only logicals
# you can swap any of the map functions for any of the other map funcns 
# rather than re-writing within your funcn what it will return 
map_vec(orgs, some_att) 
# is equivalent to ... 
map(orgs, some_att) |>
  unlist()
# map_ lgl for logicals, but 0s and 1s will work for logicals by the way
# map_chr for characters, _dbl, _int, _
map_int(orgs, some_att) # ok 
map_chr(orgs, some_att) # err

## brendan's function to test map_lgl by turning our ints into logicals ie booleans
some_att <- function(org){
  
  num <- ae_attendances |>
    filter(org_code == {{org}}) |>
    summarise(sum = sum(attendances)) |>
    pull(sum)
  
  num %% 2 == 0
  
}
# and it can coerce back to strings. 

# if getting lots of 1x1 tibbles, use list_rbind() to coerce to a good tibble. 
# it's possible to column bind too, but rbind() makes it more readable
map(orgs, some_att) |> 
  list_rbind(names_to = "THING")
# NOPE 

polo_list |> list_rbind(names_to = "SOMETHING")
# nope

map(orgs, some_att) |> 
  list_cbind(name_repair = "stringthing")
# nope 

# walk ... rather than return sthg, walk just executes the code. 
# brendan likes to put ggplot calls inside a print inside a funcn 
# just goes smoother doesn't slow it down. 

some_att <- function(org){
  
  print(
    ae_attendances |>
      filter(org_code == {{org}}) |>
      ggplot() +
      geom_col(aes(x = period, y = attendances)) +
      facet_wrap(~type, ncol=1) + 
      ggtitle({{org}})
  )
  
}
orgs <- sample(unique(ae_attendances$org_code), 10)
map(orgs, some_att)
walk(orgs, some_att)
walk(.x = orgs, .f = some_att) # remember just the function name not some_att()

some_att("RF4", attendances)
some_att("RF4", breaches)

# walk2 is the variant that takes 2 args, .x and .y in our case 
# attendances or breaches or admissions 

some_att <- function(org, data_type){
  
  print(
    ae_attendances |>
      filter(org_code == {{org}}) |>
      ggplot() +
      geom_col(aes(x = period, y = {{data_type}})) +
      facet_wrap(~type, ncol=1) +
      ggtitle({{org}})
  )
  
}

some_att("RF4", attendances)
some_att("RF4", breaches)
walk2(.x = orgs, .y = "attendances", .f = some_att) # wrong graph

# and map2 lets you use funcns with 2 args 
# ignore the below bit on .x and .y , better to use arg position

some_att <- function(org, data_type){
  
  ae_attendances |>
    filter(org_code == {{org}}) |>
    summarise(sum = sum(.data[[data_type]]))
  
}
map2(.x = orgs, .y = "attendances", .f = some_att)
# this is an equivalent to what summarize() can do for us
map2(.x = orgs, .y = "attendances", .f = some_att) |> 
  list_rbind()

# pmap is kind of similar but we name the arguments by their position inside a list
# warning pmap has changed a lot since the training was written! 
pmap(..1 = orgs, ..2 = "attendances", ..3 = some_att) |> 
  list_rbind() # nope

pmap(list(orgs, "attendances"), .f = some_att) |>
  list_rbind() # yes
# and now we can add a specific year
pmap(list(orgs, "attendances", 2019), .f = some_att) |>
  list_rbind()
#??

some_att <- function(org, data_type, year){
  
  ae_attendances |>
    filter(org_code == {{org}},
           year(period) == year) |>
    summarise(sum = sum(.data[[data_type]])) |>
    pull(sum)
  
}


some_att("RF4", "attendances", 2018)

pmap_vec(list(orgs, "attendances", 2018), .f = some_att)
# Theyr'e now doing everything by position. 
# so not a good idea to do .x and .y in map2. 

# Warning the purr docs are written with examples that are oversimplified. 