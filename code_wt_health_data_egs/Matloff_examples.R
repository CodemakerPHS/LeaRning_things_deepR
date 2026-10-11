# Examples inspired from
# The Art of Programming in R - Matloff

library("tidyverse")

source("code_wt_health_data_egs/data_structures.R")

# Ch2 Vectors
hosps_vec <- hosp_lookup$hospital_official_name
is.vector(hosps_vec) # TRUE

## any and all

# Confirm whether any names contain ampersand '&'
str_detect(hosps_vec, "&") # vector of logicals
any(str_detect(hosps_vec, "&")) # one logical
# Confirm whether all names contain ampersand
all(str_detect(hosps_vec, "&")) # one logical

# sapply() ie 'simplify apply', forerunner of purrr::map()
# Apply a function to data
shout <- function(hosp_name) {
    hosp_name <- toupper(hosp_name)
    return(hosp_name)
}
sapply(hosps_vec, shout)
# 😒 shout() returns only the uppercase string (last expression in the function).
# But sapply(hosps_vec, shout) returns a named vector where:

# the values are uppercase hospital names, and
# the names (labels on the left) are the original mixed-case strings from hosps_vec.
# So it looks like both are being output, but the mixed-case text is just the names/indices of the returned vector.

# If you want to hide those labels, either:
# * wrap the function call in unname()
unname(sapply(hosps_vec, shout))
# ... or * use the USE.NAMES attribute of sapply()
sapply(hosps_vec, shout, USE.NAMES = FALSE)
