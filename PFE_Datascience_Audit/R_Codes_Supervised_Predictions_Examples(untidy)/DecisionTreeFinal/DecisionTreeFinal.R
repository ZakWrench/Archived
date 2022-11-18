#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\scientifiqueeconomique.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$age <- as.factor(lesdonnees$age)
#lesdonnees$institution <- as.factor(lesdonnees$institution)
#lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)


#############################################

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\scientifiqueeconomique2.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$age <- as.factor(lesdonnees$age)
#lesdonnees$institution <- as.factor(lesdonnees$institution)
#lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)


#############################################

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\scientifiqueeconomique3.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$age <- as.factor(lesdonnees$age)
#lesdonnees$institution <- as.factor(lesdonnees$institution)
#lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuracy on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)
rpart.plot(x = lesdonnees_model2, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[250]]
rpart.plot(x = lesdonnees_models[[250]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)

########################

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\scientifiqueeconomique4.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$age <- as.factor(lesdonnees$age)
#lesdonnees$institution <- as.factor(lesdonnees$institution)
#lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)

########################

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\scientifiqueeconomique5.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$age <- as.factor(lesdonnees$age)
#lesdonnees$institution <- as.factor(lesdonnees$institution)
#lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)

########################
## User Experience ##
########################

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\userexperience3000row1-10.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$website <- as.factor(lesdonnees$website)
#lesdonnees$socialmedia <- as.factor(lesdonnees$socialmedia)
#lesdonnees$contact <- as.factor(lesdonnees$contact)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)

#############2#############

#Decistion tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\userexperience50000row1-100.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$website <- as.factor(lesdonnees$website)
#lesdonnees$socialmedia <- as.factor(lesdonnees$socialmedia)
#lesdonnees$contact <- as.factor(lesdonnees$contact)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)


########3########

#Decision tree

#loading libraries
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

# loading the scientifiqueeconomique dataset
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\userexperience50000row1-1000.csv")

#converting column(s) to factor 
lesdonnees$INTEREST <- as.factor(lesdonnees$INTEREST)
#lesdonnees$website <- as.factor(lesdonnees$website)
#lesdonnees$socialmedia <- as.factor(lesdonnees$socialmedia)
#lesdonnees$contact <- as.factor(lesdonnees$contact)


#Save data to lesdonnees
lesdonnees_raw <- na.omit(lesdonnees) # Raw Data
lesdonnees <- na.omit(lesdonnees) # Data for modeling

dplyr::glimpse(lesdonnees)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(lesdonnees), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
lesdonnees_train <- lesdonnees[index == 1,] #Train data
lesdonnees_test <- lesdonnees[index == 2,] #Test data

names(lesdonnees_train)
print(dim(lesdonnees_train))
print(dim(lesdonnees_test))

#Training the data
lesdonnees_model <- rpart(formula = INTEREST ~ ., data = lesdonnees_train, method = "class") # INTEREST ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = lesdonnees_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = lesdonnees_model, newdata = lesdonnees_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = lesdonnees_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= lesdonnees_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
lesdonnees_model1 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
lesdonnees_model2 <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = lesdonnees_model1, newdata = lesdonnees_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = lesdonnees_model2, newdata = lesdonnees_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred1)

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred2)


rpart.plot(x = lesdonnees_model1, yesno = 2, type = 0, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(lesdonnees_model1)

#Plotting the Cost Parameter Table
print(lesdonnees_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(lesdonnees_model1$cptable[, "xerror"])
cp_optimal <- lesdonnees_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
lesdonnees_model1_opt <- prune(tree = lesdonnees_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = lesdonnees_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = lesdonnees_model1_opt, newdata = lesdonnees_test, type = "class")

accuracy(actual = lesdonnees_test$INTEREST, predicted = pred3) #not much change in the accuracy even after pruning

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
lesdonnees_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  lesdonnees_models[[i]] <- rpart(formula = INTEREST ~., data = lesdonnees_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
lesdonnees_models[[50]]
rpart.plot(x = lesdonnees_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(lesdonnees_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- lesdonnees_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = lesdonnees_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- lesdonnees_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  lesdonnees_test, type = "class")
accuracy(actual = lesdonnees_test$INTEREST, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)


