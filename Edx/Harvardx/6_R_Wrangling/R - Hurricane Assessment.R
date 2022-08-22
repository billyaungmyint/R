library(tidyverse)
library(pdftools)
library(stringr)
options(digits = 3)    # report 3 significant digits

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
system("cmd.exe", input = paste("start", fn))

txt <- pdf_text(fn)
head(txt)
str(txt)
class(txt)

x <- str_split(txt[9] , "\n")
x
class(x)
str(x)
length(x)

s <- x[[1]]
class(s)
length(s)

s <- str_trim(s)
s
s[[1]]

header_index <- str_which(s, pattern="2015")
header_index


s
tail_index <- str_which(s, "Total")
tail_index

n <- str_count(s, "\\d+")
sum(n == 1)

out <- c(1:header_index, which(n==1), tail_index:length(s))
s <- s[-out]
length(s)

s <- str_remove_all(s, "[^\\d\\s]")

s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
s
tab <- s %>% 
  as_data_frame() %>% 
  setNames(c("day", "header")) %>%
  mutate_all(as.numeric)
tab
mean(tab$"2015")
