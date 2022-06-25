# 1 to 10 in 2s - 1 3 5 7 9
seq(1,10 , 2)

# The 25th percentile is also known as the 1st quartile, 
# the 50th percentile is also known as the median, and 
# the 75th percentile is also known as the 3rd quartile.

library(dslabs)
data(heights)

# summary gives you 
# min , 
# 1st quartile - 25% 
# median - 50%
# 3rd quartile - 75%
# max
summary(heights$height)

# find the persentiles of height column in heights
p <- seq(0.01, 0.99, 0.01)
percentiles <- quantile(heights$height, p)
percentiles

# to get individual values , 
# such as 1st quantile , 3rd quantile , 
percentiles[names(percentiles) == "25%"]
percentiles[names(percentiles) == "75%"]
