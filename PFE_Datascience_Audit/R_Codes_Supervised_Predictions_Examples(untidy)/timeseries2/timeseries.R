library(readr)
urlfile = "https://raw.githubusercontent.com/hegerty/ECON346/main/Lab2levelsData.csv"

data <- read.csv(url(urlfile))

head(data)
CNRY <- 100*data$CNY/data$CNP
JPRY <- 100*data[,3]/data[,7]
attach(data)
UKRY <- 100*UKY/UKP
USRY <- 100*USY/USP
detach(data)

#now we make a set of all 4 real gdps (including year)
RY <- cbind(data[,1], CNRY, JPRY, UKRY, USRY)
head(RY)







