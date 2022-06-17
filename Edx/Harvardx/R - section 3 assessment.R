# Section 3 assessment

library(dslabs)
data(heights)
options(digits = 3)    # report 3 significant digits for all answers

heights
# structure of the heights data frame has 2 columns and 1050 rows
# two columns are sex , a factor - Female and Male
# heights - numeric
str(heights)
class(heights)

# more males than females
plot(heights$sex)

head(heights)
head(heights , 10)

# order by head 
# in descending order of top 10
head(heights[order(heights$height , decreasing = TRUE),] ,10)

#get the average height
average_height <- mean(heights$height)

#number of those that are above average height
count(filter(heights , height > average_height))

#above average height and are females
count(filter(heights , height > average_height & sex == 'Female' ))

#what proportion are females
total_females <- count(filter(heights , sex == 'Female'))
total_males <- count(filter(heights , sex == 'Male'))
total_all <- count(heights)

proportion_of_females <- (total_females / total_all)
proportion_of_females

#minimum height in heights dataset
min(heights$height)

# use match() to find the index of the first individual with min height
match(50 , heights$height)

# subset that individual using row index
heights[1032,]

# max/min height
max_height <- max(heights$height)
min_height <- min(heights$height)
max_height
min_height

# includes the integers between min and max height
x <- 50:82        
x

# how many of the number in x are not height in dataset ?
sum(!(x %in% heights$height))


# create a new column of heights in cm , ht_cm , 1 inch = 2.54 cm
?heights # height is in inches
heights2 <- mutate(heights , ht_cm = height * 2.54)
head(heights2)
heights2[18,]
mean(heights2$ht_cm)


# create a dataframe females from height2 by filtering only females
females <- filter(heights2 , sex == 'Female' )
females
str(females)
mean(females$ht_cm)


library(dslabs)
data(olive)
head(olive)

#scatter plot
# positive linear relationship
plot(olive$palmitic , olive$palmitoleic)

# histogram
# The most common value of eicosenoic acid is below 0.05%.
hist(olive$eicosenoic)

#box plot of acid with separate distributions for each region

# southern italy has the hight median percentage
boxplot(palmitic ~ region, data = olive)

# southern italy has the most variable percentage



















