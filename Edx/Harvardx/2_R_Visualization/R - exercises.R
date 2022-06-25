library(dslabs)
data(heights)

# heights of males
x <- heights$height[heights$sex == "Male"]

# what proportion of data is more than 69 and lesser and equal to 72 ? 
mean(x>69 & x<=72)

# calculate average and standard deviation
avg <- mean(x)
stdev <- sd(x)

# only the mean and std , no x
pnorm(72 , mean = avg , sd = stdev) - pnorm(69 , mean = avg , sd = stdev)

# if got x ? what is x here ?

# compute the proportion of heights between 79 and 81.
mean(x > 79 & x <= 81)

exact <- mean(x > 79 & x <= 81)
approx <- pnorm(81 , mean(x) , sd(x)) - pnorm(79 , mean(x) , sd(x))

# how many times bigger the actual proportion is compared to approximation
exact / approx

# Note that pnorm finds the proportion less than or equal to a given value, 
# but you are asked to find the proportion greater than that value.
# use pnorm to calculate the proportion over 7 feet (7*12 inches)
# First, we will estimate the proportion of adult men that are taller than 7 feet.
# Assume that the distribution of adult men in the world as normally distributed with an average of 69 inches and a standard deviation of 3 inches.
1 - pnorm(7*12, 69, 3)

# There are 10 in NBA that above 7 foot
p <- 1 - pnorm(7*12, 69, 3)
N <- round(p * 10^9)
# so number of NBA > 7 foot / world to get the proportion
10/N


# updated for LeBron James
# height is 6 feet 8 inches
# and there are about 150 players that are at least tall in NBA
p <- 1 - pnorm(80, 69, 3)
N <- round(p * 10^9)
150/N