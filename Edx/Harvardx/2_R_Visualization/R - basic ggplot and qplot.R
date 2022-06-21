library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
data(murders)

p <- ggplot(data = murders)
# or this , p <- ggplot(murders)
# or this , p <- murders %>% ggplot()

p
class(p)

?murders

# pipe the data to ggplot , and uses aes function to define x and y , and add a layer for scatterplot using + geom_point()
murders %>% ggplot(aes(x = population, y = total)) + geom_point()

# using qplot
qplot(murders$population , murders$total)

# using label with geom_label but must define what to use for label in aes using label = 
murders %>% ggplot(aes(population, total , label = abb)) + geom_label()

# now the labels are colored according to the region they are in 
murders %>% ggplot(aes(population, total , label = abb , color = region)) + geom_label() 

# now added a title layer
murders %>% ggplot(aes(population, total , label = abb , color = region)) + geom_label() +  ggtitle("Gun murder data")