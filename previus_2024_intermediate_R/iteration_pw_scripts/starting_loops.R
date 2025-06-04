output <- vector("numeric", 10)

output

for(i in 1:10) {
  output[11 - i] <- i
}

input <- output

for(i in seq_along(input)) {
  
  output[i] <- input[i] * 2
  
  # takes each input value
  # doubles it
  # and saves it back into output
  
}

input * 2
output