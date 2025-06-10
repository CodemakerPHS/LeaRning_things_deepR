#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Learning with NES Brendan intermediate R     
# Let's summarise some data
# 11 June 2025
# Pauline Ward
# Follow-along
# https://nes-dew.github.io/KIND-training/r_training/dplyr_group_summarise.html 
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


