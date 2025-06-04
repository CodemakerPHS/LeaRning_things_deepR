# vectorised functions

1:10 ^ 2
(1:10) ^ 2


if(test one value){
  # then this
} else {
  # otherwise this
}

conditional_cube <- function(num) {
  if(num %% 2 == 0) {
    num ^ 3 }
  else {
    num ^ 2 }
}

conditional_cube(2)
conditional_cube(3)
conditional_cube(1:10)

# as loop
input <- 1:10

output <- vector("numeric", length(input))

for(i in seq_along(input)){
  output[i] <- conditional_cube(input[i])
}

output

# Vectorize
conditional_cube_vec <- Vectorize(conditional_cube)

# re-write
conditional_cube_ie <- function(num) {
  ifelse(num %% 2 == 0, num ^ 3, num ^ 2)
}
conditional_cube_ie(1:10)
