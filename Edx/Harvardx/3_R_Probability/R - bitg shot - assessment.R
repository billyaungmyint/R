# The bigshot assesment

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# The variable `B` specifies the number of times we want the simulation to run
B <- 10000

# Generate a list of summed losses 'S'. Replicate the code from the previous exercise over 'B' iterations to generate a list of summed losses for 'n' loans.  Ignore any warnings for now.
S <- replicate(B , {
  defaults <- sample(c(0,1) , size = n , replace = TRUE , prob = c(1-p_default , p_default))
  sum(defaults * loss_per_foreclosure)
})

# Plot a histogram of 'S'.  Ignore any warnings for now.
hist(S)

# -----

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Calculate the expected loss due to default out of 10,000 loans
n* (p_default * loss_per_foreclosure + (1-p_default) * 0)

# ----------------

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Compute the standard error of the sum of 10,000 loans
sqrt(n)*abs(loss_per_foreclosure)*sqrt(p_default*(1-p_default))

# -------------------

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Assign a variable `x` as the total amount necessary to have an expected outcome of $0
# Note : Formula is -lp so there is negative sign in front of loss_per_foreclosure
x <- -loss_per_foreclosure*p_default/(1-p_default)

# Convert `x` to a rate, given that the loan amount is $180,000. Print this value to the console.
x <- x/180000
x

# -------------

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Generate a variable `z` using the `qnorm` function
z <- qnorm(0.05)

# Generate a variable `x` using `z`, `p_default`, `loss_per_foreclosure`, and `n`
x <- -loss_per_foreclosure*( n*p_default - z*sqrt(n*p_default*(1-p_default)))/ ( n*(1-p_default) + z*sqrt(n*p_default*(1-p_default)))

# Convert `x` to an interest rate, given that the loan amount is $180,000. Print this value to the console.
x <- x/180000
x
# --------------------