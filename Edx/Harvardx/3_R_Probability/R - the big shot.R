# Probability - The big shot

#  Interest rate sampling model
n <- 1000 # 1000 loans
loss_per_foreclosure <- -200000 # for each loan , the bank will lose 200000
p <- 0.02 # probability of default is 0.02 or 2%
defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE) # sample if no default ,0 , if default 1 
sum(defaults) # number of defaults in 1000 from the sampling - its random
sum(defaults * loss_per_foreclosure) # from the number of defaults from sampling , how much the bank will lose ?

# Interest rate Monte Carlo simulation
B <- 10000 # number of monte carlo simulations - 10000 times - TO GET THE IDEA OF THE DISTRIBUTION
losses <- replicate(B, {
  defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE) 
  sum(defaults * loss_per_foreclosure) # for each monte carlo simulation , return the sum of losses by the bank
})

# Plotting expected losses
library(tidyverse)
data.frame(losses_in_millions = losses/10^6) %>%
  ggplot(aes(losses_in_millions)) +
  geom_histogram(binwidth = 0.6, col = "black")

# Expected value and standard error of the sum of 1,000 loans
# n is 1000 and p is 0.02
# so the below formula is : 1000 * (0.02 * 200000 + ( 1 - 0.02) * 0) - 0 because if no default , bank loses nothing
n*(p*loss_per_foreclosure + (1-p)*0)    # expected value 
# sqrt(1000) * abs(200000) * sqrt(0.02 * (1 -0.02))
sqrt(n)*abs(loss_per_foreclosure)*sqrt(p*(1-p))    # standard error

# Calculating interest rate for 1% probability of losing money
l <- loss_per_foreclosure
z <- qnorm(0.01)
z
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))\x
x/180000    # interest rate
loss_per_foreclosure*p + x*(1-p)    # expected value of the profit per loan
n*(loss_per_foreclosure*p + x*(1-p)) # expected value of the profit over n loans

# Monte Carlo simulation for 1% probability of losing money
B <- 100000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit)    # expected value of the profit over n loans
mean(profit<0)    # probability of losing money

# Expected value with higher default rate and interest rate
p <- .04
loss_per_foreclosure <- -200000
r <- 0.05
x <- r*180000
loss_per_foreclosure*p + x*(1-p)

# Calculating number of loans for desired probability of losing money
z <- qnorm(0.01)
l <- loss_per_foreclosure
n <- ceiling((z^2*(x-l)^2*p*(1-p))/(l*p + x*(1-p))^2)
n    # number of loans required
n*(loss_per_foreclosure*p + x * (1-p))    # expected profit over n loans

# Monte Carlo simulation with known default probability
B <- 10000
p <- 0.04
x <- 0.05 * 180000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit)

# Monte Carlo simulation with unknown default probability
p <- 0.04
x <- 0.05*180000
profit <- replicate(B, {
  new_p <- 0.04 + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-new_p, new_p), replace = TRUE)
  sum(draws)
})
mean(profit)    # expected profit
mean(profit < 0)    # probability of losing money
mean(profit < -10000000)    # probability of losing over $10 million