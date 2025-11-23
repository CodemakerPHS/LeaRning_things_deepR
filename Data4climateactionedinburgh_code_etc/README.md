# Edinburgh Temperature Data Scripts

## read_haduk_temperature_edinburgh.R

This script reads HadUK-Grid NetCDF temperature files and plots temperatures for the City of Edinburgh.

### Requirements

Install required packages:
```r
install.packages(c("ncdf4", "here", "tidyverse", "lubridate"))
```

### Bug Fix Applied

**Problem:** The script was failing with the error:
```
Error in `cli_block()`:
! `x` must not contain list or matrix columns:
✖ invalid columns at index(s): 1
```

**Cause:** In some cases, when `bind_rows()` combines results from multiple NetCDF file extractions, certain columns may inadvertently become list-columns, which cannot be written directly to CSV format using `write_csv()`.

**Solution:** Before writing to CSV, the script now checks for and converts any list-columns to character format using:

```r
daily_combined <- daily_combined %>%
  mutate(across(where(is.list), as.character))
```

This ensures all columns are atomic (not list-columns) before saving, preventing the write_csv error.

### Configuration

The script is configured for Edinburgh city centre by default:
- Latitude: 55.9533°N
- Longitude: -3.1883°E (west)

Data files should be placed in `data/temperature/` directory with patterns:
- Daily max: `tasmax_hadukgrid_uk_1km_day*.nc`
- Daily min: `tasmin_hadukgrid_uk_1km_day*.nc`
- Monthly mean: `tas_hadukgrid_uk_1km_mon*.nc`

### Output

The script generates:
- `edinburgh_daily_temps_point.csv` - Daily temperature data (max and min)
- `edinburgh_monthly_mean_temps_point.csv` - Monthly mean temperatures
- `edinburgh_monthly_from_daily.csv` - Monthly averages computed from daily data
- Temperature plots (printed to screen or save with `ggsave()`)

### Usage

```r
source("Data4climateactionedinburgh_code_etc/read_haduk_temperature_edinburgh.R")
```
