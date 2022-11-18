data <- read.csv("C:\\Users\\sofia noussi\\Desktop\\csv\\Final\\Final - relabeling - Copy - Copy.csv")
library(neuralnet) 

# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample( seq_len ( nrow ( data ) ), size = samplesize )

# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]
max = apply(data , 2 , max)
min = apply(data, 2 , min)

scaled = as.data.frame(scale(data, center = min, scale = max - min))


# creating training and test set
trainNN = scaled[index , ]
testNN = scaled[-index , ]



# fit neural network
set.seed(123)
NN = neuralnet(Etat ~Gender, trainNN, hidden = 6 , linear.output = T )

# plot neural network
plot(NN)

## Prediction using neural network

predict_testNN = neuralnet::compute(NN, testNN[,c(1:5)])
predict_testNN = (predict_testNN$net.result * (max(data$INTEREST) - min(data$INTEREST))) + min(data$INTEREST)

plot(datatest$INTEREST, predict_testNN, col='blue', pch=50, ylab = "predicted INTEREST NN", xlab = "real INTEREST")

abline(0,1)

# Calculate Root Mean Square Error (RMSE)
RMSE.NN = (sum((datatest$INTEREST - predict_testNN)^2) / nrow(datatest)) ^ 0.5

# Load libraries
library(boot)
library(plyr)

# Initialize variables
set.seed(50)
k = 100
RMSE.NN = NULL

List = list()

# Fit neural network model within nested for loop
for(j in 10:65){
  for (i in 1:k) {
    index = sample(1:nrow(data),j )
    
    trainNN = scaled[index,]
    testNN = scaled[-index,]
    datatest = data[-index,]
    
    NN = neuralnet(INTEREST ~ ., trainNN, hidden = 3, linear.output= T)
    predict_testNN = compute(NN,testNN[,c(1:5)])
    predict_testNN = (predict_testNN$net.result*(max(data$INTEREST)-min(data$INTEREST)))+min(data$INTEREST)
    
    RMSE.NN [i]<- (sum((datatest$INTEREST - predict_testNN)^2)/nrow(datatest))^0.5
  }
  List[[j]] = RMSE.NN
}

Matrix.RMSE = do.call(cbind, List)

boxplot(Matrix.RMSE[,56], ylab = "RMSE", main = "RMSE BoxPlot (length of traning set = 65)")

library(matrixStats)

med = colMedians(Matrix.RMSE)

X = seq(10,65)

plot (med~X, type = "l", xlab = "length of training set", ylab = "median RMSE", main = "Variation of RMSE with length of training set")

