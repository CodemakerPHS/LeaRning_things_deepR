# String manipulation and regex
# Using my own example strings, some parsing examples with escape characters and using str_match and parentheses to extract the string between two matches. Plus some notes on lookarounds.
library("stringr")

# Good example strings
qpi_name <- "QPI 2(iii): Multi-disciplinary, special, good meeting"
qpi_yr <- "2021/2022"
target_label <- "<7.5%"
#str_detect(qpi_name, "QPI 2")
#str_extract(target_label, "7\\.")
#str_sub(qpi_name, "^QPI\.*\:")

qpi_name <- "QPI 2(iii): Multi-disciplinary, special, good meeting"

grepl("P", qpi_name)   # TRUE
grepl("QPI", qpi_name) # TRUE
grepl("X", qpi_name)   # FALSE
grepl("@", qpi_name)   # FALSE
grepl("2(iii): M", qpi_name) # FALSE
#grepl("2\(", qpi_name) # error '\(' is an unrecognized escape
grepl("2\\(", qpi_name) # TRUE

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
# Because str_extract returns the first match (is vectorise). 
# Whereas str_match returns a matrix with a column for each () group. 
mymatches <- str_match(myfilenm, "validations-(.*?)\\.xlsx")
mymatches[,2]
mymatches <- str_match(myfilenm, "validations-(.*?)\\.xlsx?")
mymatches[,2]
myfilenm <- "brain-and-cns-cancer-qpi-validations-v4-0.xls"

# try lookarounds
# b preceded by a     (?<=a)b
# b not preceded by a (?<!a)b
# a followed by c     a(?=c)
# a not followed by c a(?!c)
raw_input <- "bacad"
