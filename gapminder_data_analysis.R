# load and inspect gapminder data
library(dslabs)
library(tidyverse)

# check the available datasets
data()

# load data gapminder
data(gapminder)

# print the first few rows using head()
head(gapminder)

# what is the structure of the data ?
str(gapminder)

# dimensions of gapminder - returns how many row and how many columns - and how many dimensions
dim(gapminder)

# column names of the gapminder data
names(gapminder)

# what is the data type of gapminder ?
class(gapminder)

# print the number of items in the column
length(gapminder$fertility)

# print the unique items in the column
unique(gapminder$fertility)

# how many unique items ?
length(unique(gapminder$fertility))

# why is total records not the same as unique records ?
# duplicates ? NA ?

# check for duplicates and how many of them ?
data.frame(table(gapminder$fertility))

# check for number of NAs
sum(is.na(gapminder$fertility))

# how many countries in a column using summarize
gapminder %>% summarize(length = length(country))
length(gapminder$country)

# select only 2 columns
gapminder %>% select(country , fertility)

# filter countries with fertility < 3
gapminder %>% select(country , fertility) %>% filter(fertility <3)

# count how many countries with fertility < 3 ?
gapminder %>% select(country , fertility) %>% filter(fertility <3) %>% nrow()

# average fertility and count the number
gapminder %>% select(country,fertility) %>% summarize(average = mean(fertility) , n = n())

# the above returned NA .. why ? the column has NAs ? Lets remove them.
gapminder %>% select(country,fertility) %>% summarize(average = mean(fertility , na.rm = TRUE) , n = n())

# do the same but only for Asian Continent
# note the value being filtered must be in select
gapminder %>% select(country , fertility , continent) %>% filter(continent == 'Asia') %>% summarize(average = mean(fertility , na.rm = TRUE) , n = n())

# country with highest gdp ?
which.max(gapminder$gdp)

# which.max returned the row index so need to check the row itself. Note the , 
gapminder[which.max(gapminder$gdp) , ]
# or use slice_max from dplyr
gapminder %>% slice_max(gdp)

# compare infant mortality in Sri Lanka and Turkey
gapminder %>% filter(year == 2015 & country %in% c('Sri Lanka' , 'Turkey')) %>% select(country, infant_mortality)

# how many countries per region ?
# Using groupby then summarize to get average and max gdp then arrange by region
gapminder %>% group_by(region) %>% summarize(average_gdp = mean(gdp , na.rm = TRUE) , max_fertility = max(fertility , na.rm = TRUE)) %>% arrange(.,region)

# ----------------
# lets do some plots
# ---------------


# gdp vs fertility
plot(gapminder$gdp , gapminder$fertility)

# update gdp / 10^9
plot(gapminder$gdp / 10 ^9, gapminder$fertility)

# scatter plot 
ggplot(gapminder , aes(x=gdp , y=fertility))  + geom_point()

# scatter plot after removing NAs
ggplot(gapminder , aes(x=gdp , y=fertility))  + geom_point(na.rm=TRUE)

# add color by continent
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent)) +geom_point(na.rm = TRUE ) 

# only the Asian countries and this time color by region
gapminder %>% filter(continent=='Asia') %>% ggplot(aes(x=gdp,y=fertility , col=region)) +geom_point(na.rm = TRUE )

# add color by continent and scale the axis by log10
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent)) +geom_point(na.rm = TRUE ) + scale_x_log10()

# box plot by continent
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=continent , na.rm=TRUE)) + geom_boxplot() + scale_x_log10() + scale_y_log10()

# box plot by region
gapminder %>% ggplot(aes(x=gdp,y=fertility , col=region , na.rm=TRUE)) + geom_boxplot() + scale_x_log10() + scale_y_log10()

#-----
# fertility and life expectancy across the years
# --------------

ds_theme_set()    # set plot theme
filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()


filter(gapminder, year == 1992) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()

filter(gapminder, year == 2012) %>%
  ggplot(aes(fertility, life_expectancy,color = continent)) +
  geom_point()
     
# faceting

# facet by continent and year
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(continent ~ year)

# facet by year only
filter(gapminder, year %in% c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_grid(. ~ year)

# facet by year, plots wrapped onto multiple rows
years <- c(1962, 1980, 1990, 2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>%
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_wrap(~year)
