library(caret)
heart <- read.csv2('C:\\Users\\Fatihi\\Desktop\\Lab\\SVM1\\heart3.csv', sep = ",", header = FALSE)

str(heart)

library(dplyr)
# check structure, row and column number with: glimpse(df)
# convert to numeric e.g. from 2nd column to 10th column
glimpse(heart)
#heart <- heart %>% mutate_at(c(1:14), as.numeric)

heart[, c(10)] <- sapply(heart[, c(10)], as.numeric)

#splitting data into training and testing dataset
set.seed(3033)
intrain <- createDataPartition(y = heart$V14, p=0.7, list = FALSE)
training <- heart[intrain,]
testing <- heart[-intrain,]

#testing dimension of data
dim(training)
dim(testing)

#checking if there's any NA
anyNA(heart)

summary(heart)

training[["V14"]] = factor(training[["V14"]])

#training the model

trctrl <- trainControl(method ="repeatedcv", number = 10, repeats = 3)

svm_Linear <- train(V14 ~., data = training, method = "svmLinear", trControl = trctrl, preProcess = c("center", "scale"), tuneLength = 10)

svm_Linear

test_pred <- predict(svm_Linear, newdata= testing)
test_pred #0 means safe, 1 means in danger

#testing accuracy of model

confusionMatrix(table(test_pred, testing$V14))

#optimise results of model, we customize the cost value in our linear classification

grid <- expand.grid(C= c(0, 0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2.5))

svm_Linear_Grid <- train(V14 ~., data = training, method = "svmLinear", trControl = trctrl, preProcess = c("center", "scale"),tuneGrid = grid, tuneLength = 10)
svm_Linear_Grid
plot(svm_Linear_Grid)

#test with new c values above

test_pred_grid <- predict(svm_Linear_Grid, newdata = testing)
test_pred_grid

confusionMatrix(table(test_pred_grid, testing$V14))

#more optimisation

grid2 <- expand.grid(C= c(0, 0.015, 0.055, 0.175, 0.2505, 0.505, 0.75025, 1, 1.25, 1.5, 1.75, 2.5, 3, 2))

svm_Linear_Grid2 <- train(V14 ~., data = training, method = "svmLinear", trControl = trctrl, preProcess = c("center", "scale"),tuneGrid = grid2, tuneLength = 14)
svm_Linear_Grid2
plot(svm_Linear_Grid2)

test_pred_grid2 <- predict(svm_Linear_Grid2, newdata = testing)
test_pred_grid2
confusionMatrix(table(test_pred_grid2, testing$V14))








