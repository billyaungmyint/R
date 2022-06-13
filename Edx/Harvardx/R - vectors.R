# R vectors

codes <- c(380 , 180 , 242)
country <- c('italy' , 'canada' , 'egypt')

codes
country

class(codes)
class(country)

codes <- c('country' = 380 , 'canada' = 180 , 'egypt' = 242)
codes

#or

codes <- c(380 , 180 , 242)
country <- c('italy' , 'canada' , 'egypt')
names(codes) <- country

#subsetting

codes[1]
codes[c(1,3)]
codes[1:2]

# or by name - column name

names(codes)
codes['italy']
codes[c('italy','egypt')]

codes[1]
codes[1] <- 100
codes[1]
