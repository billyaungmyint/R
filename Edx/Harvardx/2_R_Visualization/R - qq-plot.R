# define x and z
library(tidyverse)
library(dslabs)

# load the data
data(heights)
# set those records with sex == Male to TRUE to filter
index <- heights$sex=="Male"
# boolean values TRUE/FALSE for each record =with TRUE if sex == Male
index
# extract only those males' heights , meaning those records that are TRUE
x <- heights$height[index]
x
# turn those into z score , for normal distribution
z <- scale(x)
z

# proportion of data below 69.5
x <= 69.5
mean(x <= 69.5)

# calculate observed and theoretical quantiles
# 5% to 95% with increase by 5% each step
# 0.5 0.10 0.15 .... 0.95
p <- seq(0.05, 0.95, 0.05)
p
observed_quantiles <- quantile(x, p)
observed_quantiles
theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))
theoretical_quantiles

# make QQ-plot
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

# make QQ-plot with scaled values
observed_quantiles <- quantile(z, p)
# doesn't define mean and sd - so mean = 0 , sd = 1 , normal distribution
theoretical_quantiles <- qnorm(p)
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)
