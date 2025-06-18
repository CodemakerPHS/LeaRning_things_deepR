# Pauline Ward 18 june 2025
# dplyr joins with intermediate R KIND brendan

# Make a section with 
# Setup ----

library(dplyr)
x <- tibble::tribble(
  ~category, ~value, ~key,
  "x",5,3,
  "x",2,7,
  "x",4,2,
  "x",7,1,
  "x",9,1
)



y <- tibble::tribble(
  ~category, ~value, ~key,
  "y",2,5,
  "y",7,2,
  "y",3,2,
  "y",2,8,
  "y",2,14
)

# Binding ----

x |>
  bind_rows(y)|>
  bind_rows(x)

# ruin the data haha
# bind rows quite permissive
# rbind won't work
x |>
 rename(funny_thing = category) |>
  bind_rows(y)

# Error! 
x |>
  rename(funny_thing = category) |>
  rbind(y)

# nice idomatic way to 'fix' this issue using coalesce 
x |>
  rename(funny_thing = category) |>
  bind_rows(y) |>
  mutate(category = coalesce(funny_thing, category))|>
  select(-funny_thing)
# produces no NAs

# bind by list
bind_rows(list(x, y))

# .id gives things an id based on the order they're bind
x |> 
  bind_rows(y, .id = "ID") |>
  select(-category)

# Hoooorrribble!
x |>
  bind_cols(y, .name_repair = "minimal") 

# Joins ----
# cross join
x |> 
  cross_join(y)

# cross join then filter
x |> 
  cross_join(y) |>
  filter(key.x == key.y)
#..  this is an inner join
# equive 

# this produces nothing
x |>
  inner_join(y)

# this does nice inner join
x |>
  inner_join(y, by = "key")

# A new feature, join_by, is awks writing by = join_by but can be useful
# potentially powerful for unusual joins 
# but also nice tidy robust way of telling it what col to join by
# and you could use comments to specify what cols joining on
x |>
  rename(new_key = key) |>
  inner_join(y, by = join_by(new_key == key))

# contrast to the classic way is by doing a vector 
# is using a c()

# 
x |>
  inner_join(y, by = join_by(key == key))

x |>
  full_join(y, by = join_by(key == key))

x |>
  full_join(y)

# NB if try to put a condition into cross join it wont' do it, you'll get an error. 

x |>
  right_join(y, by = join_by(key == key))

x |>
  left_join(y, by = join_by(key == key))

x |>
  left_join(y, by = join_by(key > key))

# Anti-join (this is filtering, not mutating) ----
x |>
  anti_join(y, by = join_by(key == key))

x |>
  semi_join(y, by = join_by(key == key)) 

# helpers ----

x |>
  inner_join(y, by = join_by(key == key))

# equiv to above, more terse
x |>
  inner_join(y, by = join_by(key))

# keep , so you can keep both the x and y cols if you want
x |>
  inner_join(y, by = join_by(key == key),
             keep = T)

# You can specify what to do with NAs
# by default do NAs match NAs? Yes argh!!!!!!!!!
# Think this is different to sql?!
# Not great to match on missing data, so specifying can be important to do. 
x |>
  inner_join(y, by = join_by(key == key),
             na_matches = "never")

# multiple so you can specify what to do with ties
# multiple = first or last, or the default all
x |>
  inner_join(y, by = join_by(key == key),
             multiple = "first")
# helpful for being super specific about how handled


# unmatched = "drop"
x |>
  inner_join(y, by = join_by(key == key),
             unmatched = "drop",
             relationship = "one-to-many")

# nest join another helper
x |>
  nest_join(y, by = join_by(key))

# nest join another helper
x |>
  nest_join(y, by = join_by(key)) |>
  tidyr::unnest(y, names_sep = "_")

# Non-equi joins ----
# imagine the key is a date, rather than CHI, for this,
# you might join on a date
x |>
  inner_join(y, by = join_by(key,
                             value >= value))
# here would be one way of doing this
# Equates eg to find someone whose cholesterol value has dropped  as well as ...
# Is more computtnly efficient than if you did it the long way. 

# dplyr now has loads of helper functions for this
sales <- tibble(
  id = c(1L, 1L, 1L, 2L, 2L),
  sale_date = as.Date(c("2018-12-31", "2019-01-02", "2019-01-05", "2019-01-04", "2019-01-01"))
)

promos <- tibble(
  id = c(1L, 1L, 2L),
  promo_date = as.Date(c("2019-01-01", "2019-01-05", "2019-01-02"))
)

inner_join(sales, promos, join_by(id, closest(sale_date >= promo_date)))
# maybe use it for age ie greater than / less than
