mean(x<-1:10) #[1] 5.5
x

#declaring vars
randomData <- rnorm(100)

#creating a time series

months.ts <- ts(randomData, start = 2015, frequency = 12)
quarter.ts <- ts(randomData, start = 2015, frequency = 4)

#creating plots
plot(months.ts)
plot(quarter.ts)

#add a line to a previous plot
lines(months.ts, col=2)


#How do you create a time series for days?
inds <- seq(as.Date("2016-01-01"), as.Data("2017-10-14"), by = "day")
inds

#create a time series object
set.seed(25)
myts <- ts(rnorm(length(inds)),)