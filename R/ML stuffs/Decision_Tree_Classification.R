#store prediction using classification/Decision tree

#loading libraries
library(mlbench)
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

dataset <- fread("http://azzalini.stat.unipd.it/Book-DM/juice.data")
dataset2 <-setnames(dataset,c("choice","id.cust","week","StoreID","buyCH","priceCH","priceMM","discountCH","discountMM","specialCH","specialMM","loyaltyCH","loyaltyMM","salepriceMM","salepriceCH","pricediff","store7","pctdiscMM","pctdiscCH","listpricediff","store"))

head(dataset2)
str(dataset2)

dataset2$store <- as.factor(dataset2$store)
dataset2$choice <- as.factor(dataset2$choice)


dplyr::glimpse(dataset2)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(dataset2), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
store_train <- dataset2[index == 1,] #Train data
store_test <- dataset2[index == 2,] #Test data

names(store_train)
print(dim(store_train))
print(dim(store_test))

#Training the data
store_model <- rpart(formula = store ~., data = store_train, method = "class") # store ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = store_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = store_model, newdata = store_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = store_test$store) #

#Model accuraty on test data
accuracy(actual= store_test$store, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
store_model1 <- rpart(formula = store ~., data = store_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
store_model2 <- rpart(formula = store ~., data = store_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = store_model1, newdata = store_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = store_model2, newdata = store_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = store_test$store, predicted = pred1)

accuracy(actual = store_test$store, predicted = pred2)


rpart.plot(x = store_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of store_model1 #

#Plotting Cost Parameter(CP) table
plotcp(store_model1)

#Plotting the Cost Parameter Table
print(store_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(store_model1$cptable[, "xerror"])
cp_optimal <- store_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
store_model1_opt <- prune(tree = store_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = store_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = store_model1_opt, newdata = store_test, type = "class")

accuracy(actual = store_test$store, predicted = pred3) #not much change in the accuracy even after pruning

#Hyper parameter Grid search#

#Setting values for minsplit and maxdepth

#the minimum number of observations that must exist in a node in order for a split
#set the maximum depth of any node of the final tree
minsplit <- seq(1, 20 ,1) #sequence from 1 to 20 with 1 step
maxdepth <- seq(1, 20, 1)
minsplit
maxdepth

#generate a search grid
hyperparam_grid <- expand.grid(minsplit = minsplit, maxdepth = maxdepth)
hyperparam_grid #400 combination 20*20

#Number of potential models in the grid
num_models <-nrow(hyperparam_grid)

#Create an empty list
store_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  store_models[[i]] <- rpart(formula = store ~., data = store_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
store_models[[50]]
rpart.plot(x = store_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(store_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- store_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = store_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = store_test$store, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- store_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  store_test, type = "class")
accuracy(actual = store_test$store, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)





