# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab
tab <- tab[[2]]
tab

tab <- tab %>% html_table
class(tab)
tab

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

# Assessment

library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

nodes <- html_nodes(h, "table")
nodes

html_text(nodes[[8]])

html_table(nodes[[8]])

# Convert the first four tables in nodes to data frames and inspect them.

html_table(nodes[[1]])
html_table(nodes[[2]])
html_table(nodes[[3]])
html_table(nodes[[4]])
# or 
sapply(nodes[1:4], html_table) 

# Create a table called tab_1 using entry 10 of nodes. Create a table called tab_2 using entry 19 of nodes.
# Note that the column names should be c("Team", "Payroll", "Average"). You can see that these column names are actually in the first data row of each table, and that tab_1 has an extra first column No. that should be removed so that the column names for both tables match.
# Remove the extra column in tab_1, remove the first row of each dataset, and change the column names for each table to c("Team", "Payroll", "Average"). Use a full_join() by the Team to combine these two tables.
# Note that some students, presumably because of system differences, have noticed that entry 18 instead of entry 19 of nodes gives them the tab_2 correctly; be sure to check entry 18 if entry 19 is giving you problems.

tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])
col_names <- c("Team", "Payroll", "Average")
tab_1 <- tab_1[-1, -1]
tab_2 <- tab_2[-1,]
names(tab_2) <- col_names
names(tab_1) <- col_names
full_join(tab_1,tab_2, by = "Team")
nrow(full_join(tab_1,tab_2, by = "Team"))

# ---------

library(rvest)
library(tidyverse)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

h <- read_html(url)
tab <- html_nodes(h , "table")
length(tab)

tab <- read_html(url) %>% html_nodes("table")
tab
length(tab)

html_table(tab[[1]])
?html_table
html_table(tab[[2]])
html_table(tab[[3]])
html_table(tab[[4]])
html_table(tab[[5]])
tab[[1]] %>% html_table(fill = TRUE) %>% names() 













