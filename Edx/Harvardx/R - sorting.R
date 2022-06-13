# R - Sorting

library(dslabs)
data(murders)
sort(murders$total)

x <- c(31, 4, 15, 92, 65)

#sort vs order vs rank of x
sort(x)
order_index <- order(x)
rank_index <- rank(x)

#max and min

max(murders$total)
i_max <- which.max(murders$total)
murders$state[i_max]

max(x)
x_max <- which.max(x)
x[x_max]

--
  # Define a variable states to be the state names from the murders data frame
  states <- murders$state

# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)

# Define a variable ind to store the indexes needed to order the population values
ind <- order(murders$population)

# Create a data frame my_df with the state name and its rank and ordered from least populous to most 
my_df <- data.frame(states = states[ind] , ranks = ranks[ind])