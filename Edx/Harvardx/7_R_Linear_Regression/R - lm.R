# compute RSS for any pair of beta0 and beta1 in Galton's data
library(HistData)
library(tidyverse)
data("GaltonFamilies")
set.seed(1983)
galton_heights <- GaltonFamilies %>%
  filter(gender == "male") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(father, childHeight) %>%
  rename(son = childHeight)
rss <- function(beta0, beta1){
  resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  return(sum(resid^2))
}

# plot RSS as a function of beta1 when beta0=25
beta1 = seq(0, 1, len=nrow(galton_heights))
results <- data.frame(beta1 = beta1,
                      rss = sapply(beta1, rss, beta0 = 36))
results
results %>% ggplot(aes(beta1, rss)) + geom_line() + 
  geom_line(aes(beta1, rss))

# fit regression line to predict son's height from father's height
# When calling the lm() function, the variable that we want to predict is put to the left of the ~ symbol, 
# and the variables that we use to predict is put to the right of the ~ symbol. 
# The intercept is added automatically.
fit <- lm(son ~ father, data = galton_heights)
fit

# summary statistics
summary(fit)

# Monte Carlo simulation
B <- 1000
N <- 50
lse <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>% 
    lm(son ~ father, data = .) %>% 
    .$coef 
})
lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,]) 

# Plot the distribution of beta_0 and beta_1
library(gridExtra)
p1 <- lse %>% ggplot(aes(beta_0)) + geom_histogram(binwidth = 5, color = "black") 
p2 <- lse %>% ggplot(aes(beta_1)) + geom_histogram(binwidth = 0.1, color = "black") 
grid.arrange(p1, p2, ncol = 2)

# summary statistics
sample_n(galton_heights, N, replace = TRUE) %>% 
  lm(son ~ father, data = .) %>% 
  summary %>%
  .$coef

lse %>% summarize(se_0 = sd(beta_0), se_1 = sd(beta_1))

# plot predictions and confidence intervals
galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")

# predict Y directly
fit <- galton_heights %>% lm(son ~ father, data = .) 
Y_hat <- predict(fit, se.fit = TRUE)
names(Y_hat)

# plot best fit line
galton_heights %>%
  mutate(Y_hat = predict(lm(son ~ father, data=.))) %>%
  ggplot(aes(father, Y_hat))+
  geom_line()


library(Lahman)
fit <- Teams %>% filter(yearID %in% 1961:2001) %>% 
  mutate(R_per_game = R / G, BB_per_game = BB / G, HR_per_game = HR / G) %>% 
  lm(R_per_game ~ BB_per_game + HR_per_game, data = .)

summary(fit)


# ------------

galton_heights %>% ggplot(aes(father, son)) +
  geom_point() +
  geom_smooth(method = "lm")

# --------------

model <- lm(son ~ father, data = galton_heights)
predictions <- predict(model, interval = c("confidence"), level = 0.95)
data <- as_tibble(predictions) %>% bind_cols(father = galton_heights$father)

ggplot(data, aes(x = father, y = fit)) +
  geom_line(color = "blue", size = 1) + 
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2) + 
  geom_point(data = galton_heights, aes(x = father, y = son))

# ---------------


# set.seed(1989) #if you are using R 3.5 or earlier
set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")
options(digits = 3)    # report 3 significant digits

female_heights <- GaltonFamilies %>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

female_heights
class(female_heights)
str(female_heights)
length(female_heights)
names(female_heights)
ncol(female_heights)
nrow(female_heights)
summary(female_heights)
mean(is.na(female_heights$daughter))
sum(is.na(female_heights$mother))

# Fit a linear regression model predicting the mothers' heights using daughters' heights.
fit <- lm(mother ~ daughter, data = female_heights)
fit

# What is the slope of the model?
0.31
# What the intercept of the model?
44.18

fit
fit$coefficients[2]

# Predict mothers' heights using the model from Question 7 and the predict() function.

# What is the predicted height of the first mother in the dataset?
predict(fit)[1]
# What is the actual height of the first mother in the dataset?
female_heights$mother[1]


# -------------

library(Lahman)
bat_02 <- Batting %>% filter(yearID == 2002) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  select(playerID, singles, bb)

# How many players had a single rate mean_singles of greater than 0.2 per plate appearance over 1999-2001?
bat_99_01 <- Batting %>% filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  group_by(playerID) %>%
  summarize(mean_singles = mean(singles), mean_bb = mean(bb))

# How many players had a single rate mean_singles of greater than 0.2 per plate appearance over 1999-2001?
sum(bat_99_01$mean_singles > 0.2)

# How many players had a BB rate mean_bb of greater than 0.2 per plate appearance over 1999-2001?
sum(bat_99_01$mean_bb > 0.2)

# Use inner_join() to combine the bat_02 table with the table of 1999-2001 rate averages you created in the previous question.
# What is the correlation between 2002 singles rates and 1999-2001 average singles rates?

dat <- inner_join(bat_02, bat_99_01)
head(dat)
cor(dat$singles, dat$mean_singles)

# What is the correlation between 2002 BB rates and 1999-2001 average BB rates?
cor(dat$bb, dat$mean_bb)

dat %>%
  ggplot(aes(singles, mean_singles)) +
  geom_point() # scatter plot

dat %>%
  ggplot(aes(bb, mean_bb)) +
  geom_point() # scatter plot

# Fit a linear model to predict 2002 singles given 1999-2001 mean_singles.

fit <- lm(dat$singles ~ dat$mean_singles)
fit
summary(fit)

# What is the coefficient of mean_singles, the slope of the fit?
fit

# Fit a linear model to predict 2002 bb given 1999-2001 mean_bb.
# What is the coefficient of mean_bb, the slope of the fit?
fit <- lm(dat$bb ~ dat$mean_bb)
fit
