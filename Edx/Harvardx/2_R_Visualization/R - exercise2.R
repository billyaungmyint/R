library(HistData)
data(Galton)
x <- Galton$child
mean(x)
median(x)
#standard deviation
sd(x)
#mean absolute deviation 
mad(x)

# mean and median are very similar
# so is sd and mad 
# expected as data is approximated by normal distribution , which has this feature


# Now suppose that Galton made a mistake when entering the first value, forgetting to use the decimal point. 
# You can imitate this error by typing:
library(HistData)
data(Galton)
x <- Galton$child
x_with_error <- x
x_with_error[1] <- x_with_error[1]*10

# Report how many inches the average grows after this mistake
# Specifically, report the difference between the average of the data with the mistake x_with_error 
# and the data without the mistake x.
mean(x_with_error) - mean(x)

# Report how many inches the SD grows after this mistake.
# Specifically, report the difference between the SD of the data with the mistake x_with_error 
# and the data without the mistake x.
sd(x_with_error) - sd(x)

# Now we are going to see how the median and MAD are much more resistant to outliers. 
# For this reason we say that they are robust summaries.
median(x_with_error) - median(x)

# now for mad
mad(x_with_error) - mad(x)

# how to check ?
# boxplot , histogram or qqplot would show this outlier

# see how big the change after first entry changed 

x <- Galton$child
error_avg <- function(k){
  x_with_error <- x
  x_with_error[1] <- k 
  mean(x_with_error)
}

error_avg(10000)
error_avg(-10000)

