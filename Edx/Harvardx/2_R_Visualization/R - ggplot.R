# breaking down ggplot2

# 1 - Data
# 2 - type of plot - bar ? scatter ? histogram ? boxplot ? qqplot ? - in ggplot , it is called geometry component
# 3 - Aesthetic Mappings - x and y axis , colors etc

# other components 
# 4 - range of x and y axis - such a log scale -  referred to them as scale components
# 5 - label , title , legend 
# 6 - theme / style - such as economist style.

# --------------

library(tidyverse)
library(dslabs)
data(murders)

ggplot(data = murders)

# all 3 are the same
#ggplot(data = x)
#ggplot(x)
#x %>% ggplot()

murders %>% ggplot()

p <- ggplot(data = murders)
class(p)
print(p)    # this is equivalent to simply typing p
p