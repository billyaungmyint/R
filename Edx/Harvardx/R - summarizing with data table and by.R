# load packages and prepare the data - heights dataset
library(tidyverse)
library(dplyr)
library(dslabs)
data(heights)
heights <- setDT(heights)

# summarizing in dplyr
s <- heights %>% 
  summarize(average = mean(height), standard_deviation = sd(height))

# summarizing in data.table
s <- heights[, .(average = mean(height), standard_deviation = sd(height))]

# subsetting and then summarizing in dplyr
s <- heights %>% 
  filter(sex == "Female") %>%
  summarize(average = mean(height), standard_deviation = sd(height))

# subsetting and then summarizing in data.table
s <- heights[sex == "Female", .(average = mean(height), standard_deviation = sd(height))]

# previously defined function
median_min_max <- function(x){
  qs <- quantile(x, c(0.5, 0, 1))
  data.frame(median = qs[1], minimum = qs[2], maximum = qs[3])
}

# multiple summaries in data.table
heights[, .(median_min_max(height))]

# grouping then summarizing in data.table
heights[, .(average = mean(height), standard_deviation = sd(height)), by = sex]