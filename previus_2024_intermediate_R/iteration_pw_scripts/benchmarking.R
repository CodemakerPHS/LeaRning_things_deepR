# install.packages("microbenchmark")
library(tidyverse)
library(microbenchmark)

my_times <- microbenchmark(assign = {
  output <- vector("numeric", 10)
  for (i in seq_along(1:10000)) {
    output[i] <- i ^ 2
  }
},
grow = {
  output2 <- vector("numeric", 0)
  for (i in seq_along(1:10000)) {
    output2 <- c(output2, i ^ 2)
  }
},
times = 10L)

autoplot(my_times)
