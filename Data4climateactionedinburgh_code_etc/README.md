# Edinburgh Temperature Data Scripts

## read_haduk_temperature_edinburgh.R

This script reads HadUK temperature data for Edinburgh and saves it to a CSV file.

### Bug Fix Applied

**Problem:** The script was failing with the error:
```
Error in `cli_block()`:
! `x` must not contain list or matrix columns:
✖ invalid columns at index(s): 1
```

**Cause:** The `daily_combined` dataframe contained a list-column (`temperature`), which cannot be written directly to CSV format using `write_csv()`.

**Solution:** Transform the list-column into regular atomic columns before saving. The script now:

1. Uses `map_dbl()` to calculate summary statistics from the list-column:
   - `temp_mean`: Mean temperature for each day
   - `temp_min`: Minimum temperature for each day
   - `temp_max`: Maximum temperature for each day

2. Removes the original list-column using `select(-temperature)`

3. Writes the flattened dataframe to CSV

### Alternative Approach

If you need to preserve all individual measurements rather than summary statistics, uncomment the "Option 2" code at the end of the script, which uses `unnest()` to expand the list-column into multiple rows.

### Usage

```r
source("read_haduk_temperature_edinburgh.R")
```

The script will create `edinburgh_daily_temps_point.csv` in the project root directory.
