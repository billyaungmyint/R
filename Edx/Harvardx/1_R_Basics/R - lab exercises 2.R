library(dslabs)
data(heights)

sum(ifelse(heights$sex == 'Male' , 2 , 1))

mean(ifelse(heights$height > 72 , heights$height , 0))

# 12 inch = 1 foot
inches_to_ft <- function(x) {
  x / 12
}

# if 144 inches then 12 inches
inches_to_ft(144)

# height less than 5 feet
sum(heights$height < 60)

any(TRUE, TRUE, TRUE) #TRUE
any(TRUE, TRUE, FALSE) # TRUE
any(TRUE, FALSE, FALSE) # TRUE
any(FALSE, FALSE, FALSE) # FALSE
all(TRUE, TRUE, TRUE) # TRUE
all(TRUE, TRUE, FALSE) # FALSE
all(TRUE, FALSE, FALSE) # FALSE
all(FALSE, FALSE, FALSE)


# define a vector of length m
m <- 10
f_n <- vector(length = m)

# make a vector of factorials
_________{
  f_n[n] <- factorial(n)
}

# inspect f_n
f_n