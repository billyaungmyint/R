# The qnorm() function gives the theoretical value of a quantile 
# with probability p of observing a value equal to or less than that quantile value 
# given a normal distribution with mean mu and standard deviation sigma

# qnorm(p, mu, sigma)

# By default, mu=0 and sigma=1. 
# Therefore, calling qnorm() with no arguments gives quantiles for the standard normal distribution.

# qnorm(p)

# Suppose male heights follow a normal distribution with a mean of 69 inches and standard deviation of 3 inches. 
# The theoretical quantiles are

p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, 69, 3)
theoretical_quantiles
