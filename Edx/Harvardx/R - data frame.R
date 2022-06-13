name <- c("Mandi", "Amy", "Nicole", "Olivia")
distance <- c(0.8, 3.1, 2.8, 4.0)
time <- c(10, 30, 40, 50)

df <- data.frame(name = name , distance = distance , 'time_hour' = time / 60)
df
df$speed <- (speed = distance / time)
df

max(df$speed)
