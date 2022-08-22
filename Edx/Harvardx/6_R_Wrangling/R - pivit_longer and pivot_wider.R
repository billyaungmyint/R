library(dslabs)
library(tidyverse)

data(co2)

head(co2)

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))

head(co2_wide)

co2_tidy <- pivot_longer(co2_wide, -year, names_to = "month", values_to = "co2")

co2_tidy

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()

# --------

library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)

head(dat)
tail(dat)
str(dat)
dim(dat)
levels(dat$gender) # not a factor - but a char
nrow(dat)
ncol(dat)
summary(dat)

dat_tidy <- pivot_wider(dat, names_from = gender, values_from = admitted)

head(dat_tidy)

tmp <- gather(admissions, key, value, admitted:applicants)
head(tmp)


tmp2 <- unite(tmp, column_name, c(key, gender))
head(tmp2)

