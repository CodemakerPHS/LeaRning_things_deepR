# :-( won't let me scroll down argh. 
a_vector <- c(99,777,1,0)
for (i in a_vector){
  #print(i ^ 3) # i cubed
  result <- i^2 
  result |>
    print()
}

x <- 2

while (x < 1000){
  x <-x ^ 2 # square it!
  print(x)
}

vector2 <- c(3,8,12,19,960)

my_output_vec <- vector("character", length = 10)

for (j in vector2){
  
  my_output_vec[j] <- j + 100
  #print(j + 100)
}
#  a thousand NAs
my_output_vec

input_vec <- c("Tinkywinky", "Dipsy", "Lala", "Po")
output_vec_teletubbies <- vector("character", length = 4)
for(k in seq_along(input_vec)){
  output_vec_teletubbies[k] <- input_vec[k] |>
    toupper()
}
output_vec_teletubbies

lower_words <- c("cat", "hat", "bat")
lower_words |>
  toupper()


# nested loop broken
for (i in 101:109){
  for (j in 1:5){
    print(paste0("I'm the innter inner loop ", j))
    print("still in outer -")
    print(i)
  }
  print(paste0("This is the OUTER LOOP1?! "), i )
}

# fix from Brendan 
for(i in 101:109){
  for(j in 1:5){
    print(paste0("I'm the very inner loop ", j))
    print("still within the outer-")
    print(i)
  }# end of inner loop
  paste0("THIS IS THE OUTER LOOP?!?!", i) |>
    print()
} # end of outer loop

# Brendan's 
for(i in 1:5) {
  print(paste("outer is", i))
  
  for(j in 1:5) {
    print(paste("inner is", j))
  }
  
}





















