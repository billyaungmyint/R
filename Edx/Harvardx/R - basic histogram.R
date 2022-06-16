# basic histogram

library(dslabs)
hist(murder_rate)

# which is the state with more thna 15 ?
# use which.max to find the index of highest value

murders$state[which.max(murder_rate)]
