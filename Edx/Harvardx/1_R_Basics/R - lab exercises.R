# Create function called `sum_n`
sum_n <- function(x) {
  s_n <- 1:x
  sum(s_n)
}

# Use the function to determine the sum of integers from 1 to 5000
sum_n(5000)

# Create `altman_plot` 
altman_plot <- function(x , y) {
  plot(x+y , y-x)
}

# Write a function compute_s_n with argument n that for any given n computes the sum of 1 + 2^2 + ...+ n^2
compute_s_n <- function(n){
  x <- 1:n
  sum(x**2)
}

# Report the value of the sum when n=10
compute_s_n(10)

# Define a function and store it in `compute_s_n`
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}

# Create a vector for storing results
s_n <- vector("numeric", 25)

# write a for-loop to store the results in s_n
for(i in 1:25) {
  s_n[i] <- compute_s_n(i)
}

#  Create the plot 
plot(n , s_n)

# Check that s_n is identical to the formula given in the instructions.
identical(s_n , n*(n+1)*(2*n+1)/6)