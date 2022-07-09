# load and inspect gapminder data
library(dslabs)
library(tidyverse)

# check the available datasets
data()

# load data gapminder
data(gapminder)

# print the first few rows using head()
head(gapminder)

# what is the structure of the data ?
str(gapminder)

# dimensions of gapminder - returns how many row and how many columns - and how many dimensions
dim(gapminder)

# column names of the gapminder data
names(gapminder)

# what is the data type of gapminder ?
class(gapminder)

# print the number of items in the column
length(gapminder$fertility)

# print the unique items in the column
unique(gapminder$fertility)

# how many unique items ?
length(unique(gapminder$fertility))

# why is total records not the same as unique records ?
# duplicates ? NA ?

# check for duplicates and how many of them ?
data.frame(table(gapminder$fertility))

# check for number of NAs
sum(is.na(gapminder$fertility))

# how many countries in a column using summarize
gapminder %>% summarize(length = length(country))
length(gapminder$country)

# select only 2 columns
gapminder %>% select(country , fertility)

# filter countries with fertility < 3
gapminder %>% select(country , fertility) %>% filter(fertility <3)

# count how many countries with fertility < 3 ?
gapminder %>% select(country , fertility) %>% filter(fertility <3) %>% nrow()

# average fertility and count the number
gapminder %>% select(country,fertility) %>% summarize(average = mean(fertility) , n = n())

# the above returned NA .. why ? the column has NAs ? Lets remove them.
gapminder %>% select(country,fertility) %>% summarize(average = mean(fertility , na.rm = TRUE) , n = n())

# do the same but only for Asian Continent
# note the value being filtered must be in select
gapminder %>% select(country , fertility , continent) %>% filter(continent == 'Asia') %>% summarize(average = mean(fertility , na.rm = TRUE) , n = n())

# country with highest gdp ?
which.max(gapminder$gdp)

# which.max returned the row index so need to check the row itself. Note the , 
gapminder[which.max(gapminder$gdp) , ]
# or use slice_max from dplyr
gapminder %>% slice_max(gdp)

# compare infant mortality in Sri Lanka and Turkey
gapminder %>% filter(year == 2015 & country %in% c('Sri Lanka' , 'Turkey')) %>% select(country, infant_mortality)

# how many countries per region ?
# Using groupby then summarize to get average and max gdp then arrange by region
gapminder %>% group_by(region) %>% summarize(average_gdp = mean(gdp , na.rm = TRUE) , max_fertility = max(fertility , na.rm = TRUE)) %>% arrange(.,region)

# ----------------
# lets do some plots
# ---------------


# gdp vs fertility
plot(gapminder$gdp , gapminder$fertility)

# update gdp / 10^9
plot(gapminder$gdp / 10 ^9, gapminder$fertility)

# scatter plot 
ggplot(gapminder , aes(x=gdp , y=fertility))  + geom_point()

# scatter plot after removing NAs
ggplot(gapminder , aes(x=gdp , y=fertility))  + geom_point(na.rm=TRUE)

# add color by continent
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent)) +geom_point(na.rm = TRUE ) 

# only the Asian countries and this time color by region
gapminder %>% filter(continent=='Asia') %>% ggplot(aes(x=gdp,y=fertility , col=region)) +geom_point(na.rm = TRUE )

# add color by continent and scale the axis by log10
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent)) +geom_point(na.rm = TRUE ) + scale_x_log10()

# box plot by continent
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent , na.rm=TRUE)) + geom_boxplot() + scale_x_log10() + scale_y_log10()

# box plot by region
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=region , na.rm=TRUE)) + geom_boxplot() + scale_x_log10() + scale_y_log10()

#-----
# fertility and life expectancy across the years
# --------------

ds_theme_set()    # set plot theme
filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()


filter(gapminder, year == 1992) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()

filter(gapminder, year == 2012) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()
     
# faceting

# facet by continent and year
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(continent ~ year)

# facet by year only
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(. ~ year)

# facet by year, plots wrapped onto multiple rows
years <- c(1962, 1980, 1990, 2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>%
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_wrap(~year)

# --------------
# probability
# ----------------

# Disecret probability

# paste 

number <- "Three"
suit <- "Hearts"
paste(number, suit)

# joining vectors element-wise with paste
paste(letters[1:5], as.character(1:5))

# expand.grid

# generating combinations of 2 vectors with expand.grid
expand.grid(pants = c("blue", "black"), shirt = c("white", "grey", "plaid"))


suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King")
deck <- expand.grid(number = numbers, suit = suits)
deck <- paste(deck$number, deck$suit)

# probability of drawing a king
kings <- paste("King", suits)
# remember , TRUE = 1 , FALSE = 0 so mean of deck %in% kings = proportion of TRUE values , 1s.
mean(deck %in% kings)

# Permutations and combinations
#library is gtools

library(gtools)
permutations(5,2)    # ways to choose 2 numbers in order from 1:5
permutations(3,2)    # order matters
combinations(3,2)    # order does not matter


# Probability of drawing a second king given that one king is drawn
hands <- permutations(52,2, v = deck)
first_card <- hands[,1]
second_card <- hands[,2]
sum(first_card %in% kings)

sum(first_card %in% kings & second_card %in% kings) / sum(first_card %in% kings)

# Probability of a natural 21 in blackjack
aces <- paste("Ace", suits)
facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

hands <- combinations(52, 2, v=deck) # all possible hands

# probability of a natural 21 given that the ace is listed first in `combinations`
mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# probability of a natural 21 checking for both ace first and ace second
mean((hands[,1] %in% aces & hands[,2] %in% facecard)|(hands[,2] %in% aces & hands[,1] %in% facecard))


# Monte Carlo simulation of natural 21 in blackjack - replicate replicate replicate!!
# code for one hand of blackjack
hand <- sample(deck, 2)
hand

# code for B=10,000 hands of blackjack
B <- 10000
results <- replicate(B, {
  hand <- sample(deck, 2)
  (hand[1] %in% aces & hand[2] %in% facecard) | (hand[2] %in% aces & hand[1] %in% facecard)
})
mean(results)

# birthday problem
# checking for duplicated bdays in one 50 person group
n <- 50
bdays <- sample(1:365, n, replace = TRUE)    # generate n random birthdays
any(duplicated(bdays))    # check if any birthdays are duplicated

# Monte Carlo simulation with B=10000 replicates
B <- 10000
results <- replicate(B, {    # returns vector of B logical values
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
})
mean(results)    # calculates proportion of groups with duplicated bdays

# sapply
x <- 1:10
sapply(x, sqrt)    # this is equivalent to sqrt(x)

# birthday problem with sapply

# function to calculate probability of shared bdays across n people
compute_prob <- function(n, B = 10000) {
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

n <- seq(1, 60)

prob <- sapply(n, compute_prob)    # element-wise application of compute_prob to n
plot(n, prob)

# function for computing exact probability of shared birthdays for any n
exact_prob <- function(n){
  prob_unique <- seq(365, 365-n+1)/365   # vector of fractions for mult. rule
  1 - prod(prob_unique)    # calculate prob of no shared birthdays and subtract from 1
}

# applying function element-wise to vector of n values
eprob <- sapply(n, exact_prob)

# plotting Monte Carlo results and exact probabilities on same graph
plot(n, prob)    # plot Monte Carlo results
lines(n, eprob, col = "red")    # add line for exact prob


# This code runs Monte Carlo simulations to estimate the probability of shared birthdays using several B values and plots the results. 
# When B is large enough that the estimated probability stays stable, then we have selected a useful value of B.
B <- 10^seq(1, 5, len = 100)    # defines vector of many B values
compute_prob <- function(B, n = 22){    # function to run Monte Carlo simulation with each B
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

prob <- sapply(B, compute_prob)    # apply compute_prob to many values of B
plot(log10(B), prob, type = "l")    # plot a line graph of estimates 

# Monty Hall Problem - stick
B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)    # open door with no prize that isn't chosen
  stick <- my_pick    # stick with original door
  stick == prize_door    # test whether the original door has the prize
})
mean(stick)    # probability of choosing prize door when sticking

# Monty Hall Problem - switch
switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen first
  show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)    # open door with no prize that isn't chosen
  switch <- doors[!doors%in%c(my_pick, show)]    # switch to the door that wasn't chosen first or opened
  switch == prize_door    # test whether the switched door has the prize
})
mean(switch)    # probability of choosing prize door when switching

#-----------------------------
# continuous probability

# cumulative distribution function (CDF) 

# define x as male height
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

# Given a vector x, we can define a function for computing the CDF of x using:
F <- function(a) mean(x <= a)
1 - F(70)    # probability of male taller than 70 inches

# using pnorm to estimate the probability that a male is taller than 70.5 inches ,
1 - pnorm(70.5, mean(x), sd(x))

# take note of Discretization

# The probability of a single value is not defined for a continuous distribution.
# The quantity with the most similar interpretation to the probability of a single value is the probability density function 
# In R, the probability density function for the normal distribution is given by dnorm().
# Note that dnorm() gives the density function and pnorm() gives the distribution function, which is the integral of the density function.

library(tidyverse)
x <- seq(-4, 4, length = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x, f)) +
  geom_line()

# rnorm(n, avg, s) generates n random numbers from the normal distribution with average avg and standard deviation s.

# define x as male heights from dslabs data
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

# generate simulated height data using normal distribution - both datasets should have n observations
n <- length(x)
avg <- mean(x)
s <- sd(x)
simulated_heights <- rnorm(n, avg, s)

# plot distribution of simulated_heights
data.frame(simulated_heights = simulated_heights) %>%
  ggplot(aes(simulated_heights)) +
  geom_histogram(color="black", binwidth = 2)

# impt
#  Monte Carlo simulation of tallest person over 7 feet
B <- 10000
tallest <- replicate(B, {
  simulated_data <- rnorm(800, avg, s)    # generate 800 normally distributed random heights
  max(simulated_data)    # determine the tallest height
})
mean(tallest >= 7*12)    # proportion of times that tallest person exceeded 7 feet (84 inches)

# R provides functions for density (d), quantile (q), probability distribution (p) and random number generation (r) for many of these distributions.

# Use d to plot the density function of a continuous distribution. 
# Here is the density function for the normal distribution (abbreviation norm())

x <- seq(-4, 4, length.out = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x,f)) +
  geom_line()





# --------------
# inference
# ----------------

# We want to predict the proportion of the blue beads in the urn, the parameter p . 
# The proportion of red beads in the urn is 1 - p and the spread is 2p - 1.

library(tidyverse)
library(dslabs)
# a function for taking a random draw of size n from the urn
take_poll(25)    # draw 25 beads

# Many common data science tasks can be framed as estimating a parameter from a sample.

# CLT - Central Limit Theorem

# Computing the probability of X_bar being within .01 of p
X_hat <- 0.48
se <- sqrt(X_hat*(1-X_hat)/25)
pnorm(0.01/se) - pnorm(-0.01/se)

# The margin of error is defined as 2 times the standard error of the estimate X_bar

# We can run Monte Carlo simulations to compare with theoretical results assuming a value of p.
# In practice,p  is unknown. 
# We can corroborate theoretical results by running Monte Carlo simulations with one or several values of p.

p <- 0.45    # unknown p to estimate
N <- 1000

# simulate one poll of size N and determine x_hat
x <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
x_hat <- mean(x)

# simulate B polls of size N and determine average x_hat
B <- 10000    # number of replicates
N <- 1000    # sample size per replicate
x_hat <- replicate(B, {
  x <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
  mean(x)
})

# Histogram and QQ-plot of Monte Carlo results

library(tidyverse)
library(gridExtra)
p1 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(x_hat)) +
  geom_histogram(binwidth = 0.005, color = "black")
p2 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(sample = x_hat)) +
  stat_qq(dparams = list(mean = mean(x_hat), sd = sd(x_hat))) +
  geom_abline() +
  ylab("X_hat") +
  xlab("Theoretical normal")
grid.arrange(p1, p2, nrow=1)





# --------------
# machine learning
# ----------------