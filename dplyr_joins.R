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
# by default do NAs match NAs?
# Think this is different to sql?!
