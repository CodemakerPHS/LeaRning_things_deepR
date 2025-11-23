library(tidyverse)
library(here)
library(sf)

# Read HadUK temperature data for Edinburgh
# This script extracts temperature data for Edinburgh point location

# Define Edinburgh coordinates (roughly city center)
edinburgh_point <- st_point(c(-3.188, 55.953)) %>%
  st_sfc(crs = 4326)

# Read the temperature data (example - adjust path as needed)
# This would typically read NetCDF or similar climate data files
# For demonstration, creating a sample that would cause the error

# Simulate reading climate data that results in list-columns
# This often happens when extracting spatial data
daily_combined <- tibble(
  date = seq.Date(as.Date("2020-01-01"), as.Date("2020-01-10"), by = "day"),
  temperature = list(
    c(5.2, 5.3, 5.1),  # Multiple measurements per day (list-column)
    c(6.1, 6.2),
    c(4.8, 4.9, 5.0),
    c(7.2, 7.1),
    c(5.5, 5.6, 5.7),
    c(6.8, 6.9),
    c(4.2, 4.3),
    c(5.9, 6.0, 6.1),
    c(7.5, 7.6),
    c(6.3, 6.4, 6.5)
  )
)

# Try to save - this will fail with the list-column error
if (nrow(daily_combined) > 0) {
  write_csv(daily_combined, here("edinburgh_daily_temps_point.csv"))
  message(
    "Saved edinburgh_daily_temps_point.csv with ",
    nrow(daily_combined),
    " rows"
  )
}
