# purpose of this exercise
# Expected value and standard error of a single draw of a random variable
# Expected value and standard error of the sum of draws of a random variable
# Monte Carlo simulation of the sum of draws of a random variable
# The Central Limit Theorem approximation of the sum of draws of a random variable
# Using z-scores to calculate values related to the normal distribution and normal random variables
# Calculating interest/premium rates to minimize chance of losing money
# Determining a number of loans/policies required to profit
# Simulating the effects of a change in event probability

library(tidyverse)
library(dslabs)
data(death_prob)

str(death_prob)
names(death_prob)
class(death_prob)
unique(death_prob$sex)
levels(death_prob$sex)

head(death_prob)

# Use death_prob to determine the death probability of a 50 year old female, p.
p <- death_prob %>% filter(age == 50 & sex == 'Female') %>% select(prob)
# vs 
p <- death_prob %>% filter(age == 50 & sex == 'Female') %>% pull(prob)
# the difference ?
p

# ---------

# The loss in the event of the policy holder's death is -$150,000 and the gain if the policy holder remains alive is the premium $1,150.
# What is the expected value of the company's net profit on one policy for a 50 year old female?
a <- -150000
b <- 1150

mu <- a * p + (1-p) * b
mu

# ---------------

# Calculate the standard error of the profit on one policy for a 50 year old female.
sigma <- abs(b-a) * sqrt(p*(1-p))
sigma

# -----------------

# What is the expected value of the company's profit over all 1,000 policies for 50 year old females?
n <- 1000
n* mu

# ---------------

# What is the standard error of the sum of the expected value over all 1,000 policies for 50 year old females?
sqrt(n) * sigma

# Use the Central Limit Theorem to calculate the probability that the insurance company loses money on this set of 1,000 policies.
pnorm(0, n*mu, sqrt(n)*sigma)

# ----------------

# Use death_prob to determine the probability of death within one year for a 50 year old male.

p_male <- death_prob %>% filter(age == 50 & sex == 'Male') %>% pull(prob)
p_male

# Suppose the company wants its expected profits from 1,000 50 year old males with $150,000 life insurance policies to be $700,000. 
# Use the formula for expected value of the sum of draws with the following values and solve for the premium :

p <- p_male
mu_sum <- 700000
n <- 1000
a <- -150000

b <- (mu_sum/n-a*p)/(1-p)
b

# Using the new 50 year old male premium rate, calculate the standard error of the sum of 1,000 premiums.
sigma_sum <- sqrt(n)*abs(b-a)*sqrt(p*(1-p))
sigma_sum

# What is the probability of losing money on a series of 1,000 policies to 50 year old males?
# Use the Central Limit Theorem. - mean pnorm
pnorm(0, mu_sum , sigma_sum)

# Life insurance rates are calculated using mortality statistics from the recent past. 
# They are priced such that companies are almost assured to profit as long as the probability of death remains similar. 
# If an event occurs that changes the probability of death in a given age group, the company risks significant losses.

# In this 6-part question, we'll look at a scenario in which a lethal pandemic disease increases the probability of death within 1 year for a 50 year old to .015. 
# Unable to predict the outbreak, the company has sold 1,000 $150,000 life insurance policies for $1,150.

# What is the expected value of the company's profits over 1,000 policies?
p <- 0.015
n <- 1000
a <- -150000
b <- 1150

# remember to times n , number of policies
exp <- n * (p * a + ( 1 -p) * b)
exp

# -------------------

# What is the standard error of the expected value of the company's profits over 1,000 policies?
se <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
se

# ------------

# What is the probability of the company losing money?
# using normal distribution
pnorm(0 , exp , se)

# Suppose the company can afford to sustain one-time losses of $1 million, but larger losses will force it to go out of business.
# What is the probability of losing more than $1 million?

pnorm(-1000000 , exp , se)

# ----------

# Investigate death probabilities p <- seq(.01, .03, .001).
# What is the lowest death probability for which the chance of losing money exceeds 90%?

p <- seq(.01, .03, .001)
a <- -150000    # loss per claim
b <- 1150    # premium - profit when no claim
n <- 1000

p_lose_money <- sapply(p, function(p){
  exp_val <- n*(a*p + b*(1-p))
  se <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
  pnorm(0, exp_val, se)
})

data.frame(p, p_lose_money) %>%
  filter(p_lose_money > 0.9) %>%
  pull(p) %>%
  min()

# -------------------------

# Investigate death probabilities p <- seq(.01, .03, .0025).
# What is the lowest death probability for which the chance of losing over $1 million exceeds 90%?

p <- seq(.01, .03, .0025)
a <- -150000    # loss per claim
b <- 1150    # premium - profit when no claim
n <- 1000

p_lose_money <- sapply(p, function(p){
  exp_val <- n*(a*p + b*(1-p))
  se <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
  pnorm(-1000000, exp_val, se)
})

data.frame(p, p_lose_money) %>%
  filter(p_lose_money > 0.9) %>%
  pull(p) %>%
  min()

# ------------

# Define a sampling model for simulating the total profit over 1,000 loans with probability of claim p_loss = .015, loss of -$150,000 on a claim, 
# and profit of $1,150 when there is no claim. Set the seed to 25, then run the model once.
# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding") instead of set.seed(x). Your R version will be printed at the top of the Console window when you start RStudio.)
# What is the reported profit (or loss) in millions (that is, divided by 10^6)?

set.seed(25, sample.kind = "Rounding")

n <- 1000
p_loss <- 0.015
loss <- -150000
profit <- 1150


sum(sample(c(loss,profit) , size = n , replace = TRUE , prob = c(p_loss , 1 - p_loss))) / 10^6

# -------------

# Set the seed to 27, then run a Monte Carlo simulation of your sampling model with 10,000 replicates 
# to simulate the range of profits/losses over 1,000 loans.
# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding") instead of set.seed(x). 
# Your R version will be printed at the top of the Console window when you start RStudio.)
# What is the observed probability of losing $1 million or more?

set.seed(27, sample.kind = "Rounding")

n <- 1000
p_loss <- 0.015
loss <- -150000
profit <- 1150
B <- 10000

profit <- replicate(B , {
  outcome <- sample(c(loss,profit) , size = n , replace = TRUE , prob = c(p_loss , 1 - p_loss))
  sum(outcome) / 10^6
})
mean(profit < -1) 

# ------------------------

# Suppose that there is a massive demand for life insurance due to the pandemic, 
# and the company wants to find a premium cost for which the probability of losing money is under 5%, 
# assuming the death rate stays stable at p = 0.015 .

# Calculate the premium required for a 5% chance of losing money given n=1000 loans, probability of death p =0.015 , 
# and loss per claim -150000. Save this premium as x for use in further questions.

p <- .015
n <- 1000
l <- -150000
z <- qnorm(.05)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x

#-----------------------

# What is the expected profit per policy at this rate?
l*p + x*(1-p)

# -----------------

# What is the expected profit over 1,000 policies?
n * (l*p + x*(1-p))

# ---------------

# Run a Monte Carlo simulation with B=10000to determine the probability of losing money on 1,000 policies given the new premium x, 
# loss on a claim of $150,000, and probability of claim . Set the seed to 28 before running your simulation.
# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding") instead of set.seed(x). 
# Your R version will be printed at the top of the Console window when you start RStudio.)
# What is the probability of losing money here?

set.seed(28, sample.kind = "Rounding")
B <- 10000
profit <- replicate(B, {
  draws <- sample(c(x, l), n,
                  prob=c(1-p, p), replace = TRUE)
  sum(draws)
})

mean(profit < 0)

#--------------------

# The company cannot predict whether the pandemic death rate will stay stable. Set the seed to 29, then write a Monte Carlo simulation that for each of  iterations:
# randomly changes  by adding a value between -0.01 and 0.01 with sample(seq(-0.01, 0.01, length = 100), 1)
# uses the new random  to generate a sample of  policies with premium x and loss per claim 
# returns the profit over  policies (sum of random variable)
# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding") instead of set.seed(x). 
# Your R version will be printed at the top of the Console window when you start RStudio.)
# The outcome should be a vector of  total profits. Use the results of the Monte Carlo simulation to answer the following three questions.
# (Hint: Use the process from lecture for modeling a situation for loans that changes the probability of default for all borrowers simultaneously.)


  
set.seed(29)    # in R 3.6, set.seed(29, sample.kind="Rounding")

n <- 1000
l <- -150000

profit <- replicate(B, {
  new_p <- p + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample(c(x, l), n, 
                  prob=c(1-new_p, new_p), replace = TRUE) 
  sum(draws)
})
sum(profit)

# -------------------

# What is the probability of losing money?
mean(profit < 0)

# -------------
# What is the probability of losing more than $1 million?
mean(profit < -1*10^6)
