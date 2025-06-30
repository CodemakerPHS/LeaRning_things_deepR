#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Learning with NES Brendan intermediate R     
# Let's summarise some data
# 11 June 2025
# Pauline Ward
# Follow-along
# https://nes-dew.github.io/KIND-training/r_training/dplyr_group_summarise.html 
# 
# KIND learning network training materials by 
# KIND learning network is licensed under CC BY-SA 4.0
# 
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

library(dplyr)
# horr-RENV-ous
# had to remove then re-init
# renv::deactivate(clean = TRUE) 
# renv::init()
library(readr)
library(lubridate)
library(ggplot2)
library(NHSRdatasets)
library(skimr)


SMR_SIMD <- read_csv("https://www.opendata.nhs.scot/datastore/dump/e6849f09-3a5c-44c6-8029-260882345071?bom=True") |>
  select(-c(`_id`, contains("QF"), Country)) |>
  tidyr::separate_wider_delim(TimePeriod, "Q", names = c("Year", "Quarter")) |>
  mutate(Year = as.numeric(Year),
         Quarter = as.numeric(Quarter) * 3) |>
  mutate(Date = ymd(paste(Year, Quarter, "01"))) |>
  mutate(SIMDQuintile = case_when(SIMDQuintile == "1 - most deprived" ~ "1",
                                  SIMDQuintile == "5 - least deprived" ~ "5",
                                  TRUE ~ SIMDQuintile)) |>
  relocate(last_col()) 

#summarising all the  nums in the column
SMR_SIMD |>
  summarise(sum(NumberOfDeaths)) # returns  a tibble!

# equive 
sum(SMR_SIMD$NumberOfDeaths) # returns one val

SMR_SIMD |>
  group_by(Year)|>
  summarise(sum(NumberOfPatients))
# cos its tidyverse, don't need to quote the col nums, treats them as objex

SMR_SIMD |>
  group_by(SIMDQuintile)|> # or try year. 
  summarise(sum(NumberOfDeaths)) # returns  a tibble!

SMR_SIMD |>
  group_by(Year, SIMDQuintile)|> # or try year. 
  summarise(sum(NumberOfDeaths)) # removes only the rightmost level of grouping ie simdquintile,
# this is a bad choice that brendan doesnt lke, but it'll never change. 

# horrible 
SMR_SIMD |>
  group_by(Year, SIMDQuintile)|> # 
  summarise(sumthing = sum(NumberOfDeaths),
            meanthing = mean(NumberOfDeaths))|>
  mutate(nu_col = "ha") |>
  ungroup()


# n() gives you number of rows
SMR_SIMD |>
  group_by(Year, SIMDQuintile)|> # 
  summarise(sumthing = sum(NumberOfDeaths),
            meanthing = mean(NumberOfDeaths),
            n = n(),
            first = first(Year),
            last = last(Year))|>
  ungroup()
# n reveals i don't have four quarters in each year



skimr::skim(SMR_SIMD)

SMR_SIMD |>
  ggplot() +
  geom_line(aes(x = Date, y = NumberOfDeaths, colour = SIMDQuintile)) +
  theme_minimal()

# sad. 

SMR_SIMD |> 
  summarise(sum(NumberOfDeaths))  

SMR_SIMD |> 
  group_by(Year) |>
  summarise(sum(NumberOfDeaths)) 

SMR_SIMD |> 
  group_by(Year) |>
  summarise(sum(NumberOfDeaths)) |>
  summarise(sum(`sum(NumberOfDeaths)`)) # horrible default column names, which we'll fix in future

?group_data

SMR_SIMD |>
  group_by(Year, SIMDQuintile)|>
  group_data()
# could use pull for this

library(tidyr)

SMR_SIMD |>
  group_by(SIMDQuintile, Year) |>
  group_data() |>
  unnest(.rows) |>
  filter(Year == 2018, SIMDQuintile == 3)


SMR_SIMD |> 
  group_by(Year) |>
  summarise(total = sum(NumberOfDeaths)) |> # rename columns like select 
  arrange(desc(total)) 


tempvarble <-  SMR_SIMD |>
  +     summarise(sum = sum(NumberOfDeaths),
                  +               mean = mean(NumberOfDeaths), 
                  +               .by = c(Year, SIMDQuintile))



SMR_SIMD |>
  summarise(sum = sum(NumberOfDeaths),
            mean = mean(NumberOfDeaths), 
            .by = c(Year, SIMDQuintile))

SMR_SIMD |> 
  group_by(Year) |>
  summarise(surviving = sum(NumberOfPatients - NumberOfDeaths )) |>
  arrange(desc(surviving))  

SMR_SIMD |> 
  summarise(surviving = sum(NumberOfPatients - NumberOfDeaths), 
            .by = Year) |>
  arrange(desc(surviving)) 

SMR_SIMD |> 
  summarise(att = sum(NumberOfDeaths), .by = c(Year, Quarter)) 


SMR_SIMD |> 
  group_by(Year, Quarter) |>
  summarise(att = sum(NumberOfDeaths))


## reframe()

ae_attendances |>
  group_by(year = lubridate::floor_date(period, unit = "year")) |>
  summarise(
    year = lubridate::year(year),
    non_admissions = sum(attendances - admissions)
  )

sum <- ae_attendances |>
  group_by(year = lubridate::floor_date(period, unit = "year")) |>
  summarise(
    year = lubridate::year(year),
    non_admissions = sum(attendances - admissions)
  )

ref <- ae_attendances |>
  group_by(year = lubridate::floor_date(period, unit = "year")) |>
  reframe(
    year = lubridate::year(year),
    non_admissions = sum(attendances - admissions)
  )

waldo::compare(sum, ref)



## count() and tally()

ae_attendances |>
  count() # num of rows

# two ways to do same thing
ae_attendances |>
  count(org_code)

ae_attendances |>
  group_by(org_code)|>
  summarise(n=n())

ae_attendances |>
  tally()

# whereas on breaches will be different

ae_attendances |>
  tally(breaches)

ae_attendances |>
  count(breaches)

sum(ae_attendances$breaches)

# good idea to use  a named arugument so is clear ur using tally to get weighted tots. 
?count
# tally is niche, logic is funny, might never need it, but can be useful certain circs. 

# DROP  .drop
# only relevant where you're using factors
ae_attendances |>
  count(org_code,
        wt = breaches,
        sort = T, 
        name = "steve",
        .drop = F
        )

# factorising the male level
synthetic_news_data |>
  mutate(male = factor(male, levels = c(0,1,2))) |>
  count(male, .drop = F)
# this allows you to show there is a missing group. 

ae_attendances |>
  add_count(org_code) |>
  filter( ?...? ) # he deleted it

# gotcha - this is summing evthing in whole tibble, so bonkers big nums
ae_attendances |>
  mutate(total = sum(attendances, breaches, admissions))

# .. cos mutate respects groupings,
# so we use rowwise to group by row 
# surprisingly not the defaault 
ae_attendances |>
  rowwise() |>
  mutate(total = sum(attendances, breaches, admissions))

# so mutate can be thrown off by using a grouping that was many lines before
# by defautl if you group by, it scrubs any preceding group by
# but you can add a layer of grouping by using .add 

ae_attendances |>
  group_by(org_code) |>
  group_by(type, .add = T)|>
  mutate(total = sum(attendances, breaches, admissions))

ae_attendances |>
  rowwise()

synthetic_news_data |>
  count(died) 


synthetic_news_data |> 
  group_by(died) |> 
  summarise(n = n())  


synthetic_news_data |> 
  # group_by(died) |> 
  summarise(n = n())  


synthetic_news_data |>
  tally() 


synthetic_news_data |>
  tally(age) 


synthetic_news_data |>
  pull(age) |>
  sum() 

synthetic_news_data |>
  count(syst, sort=T) 

#add_ variants
synthetic_news_data |>
  add_count(syst, name="syst_BP_count") |>
  select(syst, last_col())


synthetic_news_data |>
  group_by(died) |>
  add_tally() |>
  slice(1:3) 


## rowwise() 

# to find the daily mean of attendances, breaches, and admissions
ae_attendances |> 
  rowwise() |>
  mutate(mean = mean(c(attendances, breaches, admissions))) 

ae_attendances |> 
  mutate(mean=mean(c(attendances, breaches, admissions))) 


ae_attendances |> 
  rowwise() |>
  mutate(mean = mean(c_across(4:6))) 



## Summary functions nth(),  first() and last()

tibble(speaker = c("steve", "steve", "emma", "steve", "emma", "emma"),
       comment = letters[1:6])  |>
  mutate(group = consecutive_id(speaker)) |>
  group_by(group, speaker) |>
  summarise(comment = last(comment)) |>
  ungroup() |>
  select(-group)


