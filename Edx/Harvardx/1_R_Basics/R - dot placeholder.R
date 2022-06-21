library(tidyverse)
library(dplyr)
library(dslabs)
data(murders)
murders <- mutate(murders, rate = total / population * 10^5)

# average rate adjusted by population size
us_murder_rate <- murders %>% 
  summarize(rate = sum(total) / sum(population) * 10^5)
us_murder_rate

# using the dot to access the rate
us_murder_rate <- murders %>% 
  summarize(rate = sum(total) / sum(population) * 10^5) %>%
  .$rate
us_murder_rate
class(us_murder_rate)