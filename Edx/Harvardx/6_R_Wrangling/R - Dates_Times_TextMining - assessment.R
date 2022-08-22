library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

gutenberg_metadata

gutenberg_metadata %>% filter(title == "Pride and Prejudice") %>% nrow()
gutenberg_metadata %>% filter(str_detect(title , "Pride and Prejudice")) %>% nrow()

gutenberg_works(title == "Pride and Prejudice")$gutenberg_id

book <- gutenberg_download(1342)
