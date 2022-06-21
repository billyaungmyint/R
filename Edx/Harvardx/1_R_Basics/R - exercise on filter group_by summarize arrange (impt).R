library(NHANES)
library(dplyr)

data("NHANES")

# filter females age between 20-29 and assign the data to tab
tab <- NHANES %>% filter(AgeDecade == ' 20-29' & Gender == 'female')

class(tab)

# first take the data NHANES
# then filter y age and gender
# then use summarize to get the mean and standard drviation (and ignore the rm  in each of them)
ref <- NHANES %>% filter(AgeDecade == " 20-29" & Gender == "female") %>% 
  summarize(average = mean(BPSysAve , na.rm = TRUE) , standard_deviation = sd(BPSysAve , na.rm = TRUE) )


# same as above but this time pull the value
ref_avg <- NHANES %>%
  filter(AgeDecade == " 20-29" & Gender == "female") %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            standard_deviation = sd(BPSysAve, na.rm=TRUE)) %>% pull(average)

# first get the data
# then filter by column name
# then group by the column name - no '' here - need to check
# then get the mean and standard deviation using summarize (remove na using na.rm = TRUE)
# then s
NHANES %>%
  filter(Gender == "female") %>% group_by(AgeDecade) %>% summarize(average = mean(BPSysAve , na.rm = TRUE) , standard_deviation = sd(BPSysAve , na.rm=TRUE))

# no need to filter here since you are group_by both AgeDecade and Gender
NHANES %>% group_by(AgeDecade , Gender) %>% summarize(average = mean(BPSysAve , na.rm = TRUE) , standard_deviation = sd(BPSysAve , na.rm = TRUE))

#first get the data
# then filter by gender and age
# then group by Race1
# then use summarize to get the average and standard deviation (ignore the NA values using na.rm = TRUE)
# then sort the average from summarize output using arrange *if the other way then arrange(desc(average))
NHANES %>%
  filter(Gender == "male" & AgeDecade==" 40-49") %>%
  group_by(Race1) %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE), 
            standard_deviation = sd(BPSysAve, na.rm=TRUE)) %>%
  arrange(average)