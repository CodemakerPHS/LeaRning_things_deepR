#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# dplyr with Brendan 
#
# 
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# nb grouping - there's a kind session on that, 
# todo check the groups
# and be aware, slice then respects the groups


library(NHSRdatasets)
library(tidyverse)
library(dplyr)

ae_attendances |>
  mutate(row = row_number()) |>
  slice(c(7,9,33:1))

ae_attendances |>
  slice_max(attendances, n = 4) 

ae_attendances |>
  slice_sample(n=8)

# slice_head
# slice_tail

ae_attendances |>
  slice_head(n=2)

synthetic_news_data |>
  glimpse(  )


syn_tbl <- synthetic_news_data |>
  glimpse(  )

synthetic_news_data |>
  glimpse() |>
  filter(age > 60) |>
  glimpse() |>
  group_by(NEWS) |>
  glimpse() |>
  summarise(resp = mean(resp)) 

LOS_model |>
  glimpse() |>
  rename(lenght_of_stay = LOS) |>
  rename_with(tolower)

# case_when
# ons 18,000 rows approx
ons_mortality |>
  count(category_1)


  ons_mortality |>
  filter(category_1 == "Total deaths") |>
  mutate(month = lubridate::month(date))

  
  ons_mortality |>
    filter(category_1 == "Total deaths") |>
    mutate(month = lubridate::month(date)) |>
    mutate(
      season = case_when(month <3 ~ "Winter", 
                         month == 12 ~ "Winter",
                         TRUE ~ "Not winter")  # alternatively use .default
    )
  
  ons_mortality |>
    filter(category_1 == "Total deaths") |>
    mutate(month = lubridate::month(date)) |>
    mutate(
      season = case_when(month <3 ~ "Winter", 
                         month == 12 ~ "Winter",
                         .default = "Rainy but not technically winter") 
    )
  
  # case_match
  ons_mortality |>
    filter(category_1 == "Total deaths") |>
    mutate(month = lubridate::month(date)) |>
    mutate(
      season = case_match(month, c(1,2,12)  ~ "Winter", 
                         .default = "Rainy but not technically winter") 
    ) |>
    relocate(last_col())
  
  # example by brendan processing Teams tscripts
  # want to lump together rows for a speaker
  
  consecutive_id(c(1,1,1,2,2,3,2,1,1,2,1,1,1,1,3,3,2,1,1))
  
  tibble(speaker = c("steve", "steve", "emma", "emma", "emma", "steve"),
         comment = LETTERS[1:6]) |>
    mutate(
      group = consecutive_id(speaker)
    )

#  even   more concise
  tibble(speaker = c("steve", "steve", "emma", "emma", "emma", "steve"),
         comment = LETTERS[1:6]) |>
        group_by(group = consecutive_id(speaker))|>
    distinct()
  
  
  
  