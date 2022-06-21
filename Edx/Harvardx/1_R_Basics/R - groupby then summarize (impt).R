library(dslabs)
library(dplyr)

murders <- mutate(murders , rate = total /population * 10^5)
str(murders)

murders %>% group_by(region) %>% summarize(median = median(rate))
