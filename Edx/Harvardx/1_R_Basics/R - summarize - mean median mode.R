library(tidyverse)
library(dplyr)
library(dslabs)
data(murders)
murders <- mutate(murders, rate = total / population * 10^5)

# minimum, median, and maximum murder rate for the states in the West region
# %>% is like Linux | 

# first you have data , murders
# then you filter it using filter from dplyr
# then pass the filtered data to summarize to get the mean , median and max using the column , rate
# and pass all to a variable called s
s <- murders %>% 
  filter(region == "West") %>%
  summarize(minimum = min(rate), 
            median = median(rate), 
            maximum = max(rate))
s

# accessing the components with the accessor $
# median and maximum comes from summmarize
s$median
s$maximum

# average rate unadjusted by population size
mean(murders$rate)

# average rate adjusted by population size
us_murder_rate <- murders %>% 
  summarize(rate = sum(total) / sum(population) * 10^5)
us_murder_rate