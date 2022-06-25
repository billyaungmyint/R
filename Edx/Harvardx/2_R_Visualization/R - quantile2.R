library(dslabs)
data(heights)
quantile(heights$height, seq(.01, 0.99, 0.01))
