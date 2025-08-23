# String manipulation and regex
# Using my own example strings, some parsing examples with escape characters
# and using str_match and parentheses to extract the string between two matches.
# Plus some notes on lookarounds.

library("stringr")

# Good example strings initialisation ----
qpi_name <- "QPI 8(iii): Multi-disciplinary, special, good meeting"
simple_qpi_name <- "QPI 12: Mindfulness available for 30 days"
qpi_yr <- "2021/2022"
target_label <- "<7.5%"
simple_target_label <- "95%"
wee_str_vec <- c(
    "90%",
    "QPI 3(i)",
    'measurability',
    "Regional networks: mapping"
)
hosp_codes <- c("J103H", "J214H", "X9999", "P101H", "J103H", "X1010")
hb_names <- c(
    "Inverpo",
    "Strathseine and Lammermuir",
    "Greater Leithland & Wassie"
)
sites <- c("C67.1", "C67.5", "C67.8")
site_names <- c("feather", "paw", "noggin")

# Detect presence, return logical Boolean
str_detect(qpi_name, "QPI 2") # FALSE
str_detect(qpi_name, "QPI 8") # TRUE

str_extract(target_label, "5.") # dot in a pattern will match any character
str_extract(target_label, "7.") # dot in a pattern will match any character
str_extract(target_label, "7\\.") # escaped dot to match just a dot
str_extract(target_label, "7.*") # dot matches any char, * quantifier any no. of times
# "7.5%"
str_extract(target_label, "7\\.*") # dot matches only dot, * quantifier any no. of times, it's only once
# "7."

qpi_name <- "QPI 2(iii): Multi-disciplinary, special, good meeting"

grepl("P", qpi_name) # TRUE
grepl("QPI", qpi_name) # TRUE
grepl("X", qpi_name) # FALSE
grepl("@", qpi_name) # FALSE
grepl("8(iii): M", qpi_name) # FALSE
#grepl("8\(", qpi_name) # error '\(' is an unrecognized escape
grepl("8\\(", qpi_name) # TRUE

# grep(pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE, fixed = FALSE)

# Task - get the version no from validation filenames.
# https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
myfilenm <- "brain-and-cns-cancer-qpi-validations-v4-0.xlsx"
str_extract(myfilenm, "\\.xlsx")
str_extract(myfilenm, "validations-")
str_extract(myfilenm, "cn?") # ? is zero or one
str_extract(myfilenm, "cn*") # * is zero or more
str_extract(myfilenm, "cn+") # + is one or more
str_extract(myfilenm, "vali[:alnum:]?") # ? is zero or one
str_extract(myfilenm, "vali[:alnum:]*") # * is zero or more
str_extract(myfilenm, "vali[:alnum:]+") # * is one or more

# wrong - takes the chars in between as well as the surrounding matching patterns
str_extract(myfilenm, "validations-(.+)\\.xlsx") # "validations-v4-0.xlsx"
str_extract(myfilenm, "validations-(.*?)\\.xlsx") # "validations-v4-0.xlsx"

# The key is to use str_match instead of str_extract AND THEN get second elt of matrix.
# Because str_extract returns the first match (is vectorised).
# Whereas str_match returns a matrix with a column for each () group.
mymatches <- str_match(myfilenm, "validations-(.*?)\\.xlsx")
mymatches[, 2]
mymatches <- str_match(myfilenm, "validations-(.*?)\\.xlsx?")
mymatches[, 2]
myfilenm <- "brain-and-cns-cancer-qpi-validations-v4-0.xls"

# Lookarounds
# a preceded by r       (?<=r)a
# a not preceded by r   (?<!r)a
# a followed by m      a(?=m)
# a not followed by m  a(?!m)
raw_input <- "dramatic"
str_extract(raw_input, "(?<=r)a") # a preceded by r
str_extract(raw_input, "(?<=r)a.*") # a preceded by r, and everything after the a.
str_extract(raw_input, "(?<!r)a.*") # a not preceded by r and then everything.
str_extract(raw_input, "a(?=m).*") # a followed by m, and then everything after the m.
str_extract(raw_input, "a(?!m).*") # a not followed by m and then everything.

## Use lookarounds to get the version number out of middle of filename
# (?<) or (?), with = or !, to extract string preceded by or followed by the matches.
str_extract(myfilenm, "(?<=-).*") # everything after the 1st dash
str_extract(myfilenm, "(?<=validations).*") # evthing after validations
str_extract(myfilenm, ".*(.x)") # wrong, did not escape dot, just gets everything
# No question mark, no lookaround, just treats brackets as a group.
str_extract(myfilenm, ".*(\\.x)") # use \\ to escape . to isolate filename extension
str_extract(myfilenm, "(?<=validations-).*(?=.xls)") # Success: "v4-0"

## Use integer indices ##
str_sub(hosp_codes, start = 1L, end = 1L) # first character, indicating geographical area
str_sub(hosp_codes, start = 2L, end = 4L) # second to fourth chars, identifying hospital

str_replace_all(hb_names, "&", "and")

## Pitfalls ##
# Don't bother with str_like(), it just allows you to use same wildcards etc as SQL LIKE.

# Beware str_start(), won't work correctly with a pipe for alternate patterns.
# Better stick with the anchors ^ and $.
# To vectorise...?
str_start(hosp_codes, "J|P")
str_detect(hosp_codes, "^J|^P")
