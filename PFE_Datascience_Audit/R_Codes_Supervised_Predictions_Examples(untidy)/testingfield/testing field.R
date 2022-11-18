#Decistion tree

#loading libraries
library(mlbench)
library(rpart)
library(rpart.plot)
library(caret)
library(Metrics)

Diabetes <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\hmmmmm\\Final\\final2\\finally\\scientifiqueeconomique5.csv")
Diabetes$INTEREST <- as.factor(Diabetes$INTEREST)
Diabetes$age <- as.factor(Diabetes$age)
Diabetes$institution <- as.factor(Diabetes$institution)
Diabetes$afford1 <- as.factor(Diabetes$afford1)

# loading the PimaIndiandiabetes dataset
data(PimaIndiansDiabetes2)

#Save data to Diabetes
Diabetes_raw <- na.omit(PimaIndiansDiabetes2) # Raw Data
Diabetes <- na.omit(PimaIndiansDiabetes2) # Data for modeling

dplyr::glimpse(Diabetes)

#splitting the dataset to 80% for training and 20% for testing

set.seed(123)
index <- sample(2, nrow(Diabetes), prob = c(0.8, 0.2), replace = TRUE) #2, : generating samples of ones and twos. nrow(x) means supplying the number of rows in x to generate. prob = c(0.8,0.2) splitting the dataset. Replace = TRUE means that the index will stay the same when used for later.
Diabetes_train <- Diabetes[index == 1,] #Train data
Diabetes_test <- Diabetes[index == 2,] #Test data

names(Diabetes_train)
print(dim(Diabetes_train))
print(dim(Diabetes_test))

#Training the data
Diabetes_model <- rpart(formula = INTEREST ~ ., data = Diabetes_train, method = "class") # diabetes ~., imply we're using all the previous column to as measure to train

#plotting the trained model
#yesno = 2: add yes/no at each level
#type = 0: Draw a split label at each split and a node label at each leaf
#extra = 0: No extra information
rpart.plot(x = Diabetes_model, yesno = 2, type = 0, extra = 0) #

#Model performance evaluation on test dataset#

#class prediction
class_predicted <- predict(object = Diabetes_model, newdata = Diabetes_test, type = "class")

#Generate a confusion matrix for the test data
confusionMatrix(data = class_predicted, reference = Diabetes_test$INTEREST) #

#Model accuraty on test data
accuracy(actual= Diabetes_test$INTEREST, predicted = class_predicted)

#Tree splitting criteria based comparison#

#Model training based on gini-based splitting criteria
Diabetes_model1 <- rpart(formula = INTEREST ~., data = Diabetes_train, method = "class", parms = list(split = "gini"))

#Model training based on information gain-based splitting criteria
Diabetes_model2 <- rpart(formula = INTEREST ~., data = Diabetes_train, method = "class", parms = list(split = "information"))

#Generate class prediction on the test data using gini-based splitting criteria
pred1 <- predict(object = Diabetes_model1, newdata = Diabetes_test, type = "class")

#Generate class prediction on test data using information gain based splitting criteria
pred2 <- predict(object = Diabetes_model2, newdata = Diabetes_test, type = "class")


#Compare classification accuracy on test data
accuracy(actual = Diabetes_test$INTEREST, predicted = pred1)

accuracy(actual = Diabetes_test$INTEREST, predicted = pred2)


rpart.plot(x = Diabetes_model1, yesno = 2, type = 3, extra = 0)


# Tree pruning of Diabetes_model1 #

#Plotting Cost Parameter(CP) table
plotcp(Diabetes_model1)

#Plotting the Cost Parameter Table
print(Diabetes_model1$cptable)

#Retrieve of optimal cp value based on cross-validated error
index <- which.min(Diabetes_model1$cptable[, "xerror"])
cp_optimal <- Diabetes_model1$cptable[index, "CP"]
index
cp_optimal

#Pruning tree based on optimal CP value
Diabetes_model1_opt <- prune(tree = Diabetes_model1, cp = cp_optimal)

#Plot the optimized model
rpart.plot(x = Diabetes_model1_opt, yesno = 2, type = 0, extra = 0)

pred3 <- predict(object = Diabetes_model1_opt, newdata = Diabetes_test, type = "class")

accuracy(actual = Diabetes_test$diabetes, predicted = pred3) #not much change in the accuracy even after pruning

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
diabetes_models <- list()

#write a loop over the rows of hyper_grid to train the grid of models
for(i in 1:num_models){
  minsplit <- hyperparam_grid$minsplit[i]
  maxdepth <- hyperparam_grid$maxdepth[i]
  
  #Train a model and store in the list
  diabetes_models[[i]] <- rpart(formula = diabetes ~., data = Diabetes_train, method = "class", minsplit = minsplit, maxdepth = maxdepth)
  
}

#Lest check model 50
diabetes_models[[50]]
rpart.plot(x = diabetes_models[[50]], yesno = 2, type = 0, extra = 0)

#Number of models inside the grid
num_models <- length(diabetes_models)

#Create an empty vector to store accuracy values
accuracy_values <- c()

#Use for loop for models accuracy estimation
for (i in 1:num_models){
  
  #Retrieve the model i from the list
  model <- diabetes_models[[i]]
  
  #Generate prediction on test data
  pred <- predict(object = model, newdata = Diabetes_test, type = "class")
  
  #Compute test accuracy and add to the empty vector accuracy values
  accuracy_values[i] <- accuracy(actual = Diabetes_test$diabetes, predicted = pred)
}

#Identify the model with maximum accuracy
best_model <- diabetes_models[[which.max(accuracy_values)]]
accuracy_values

#Print the model hyper-parameters of the best model
best_model$control

#Best_model accuracy on test data
pred <- predict(object = best_model, newdata =  Diabetes_test, type = "class")
accuracy(actual = Diabetes_test$diabetes, predicted = pred)

rpart.plot(x = best_model, yesno = 2, type = 0, extra = 0)


#####################



data <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\hmmmmm\\Final\\final2\\finally\\scientifiqueeconomique5.csv")

row_labels <- data[,6]
data$userexperience <- as.numeric(data$userexperience)

data[1,5] <- scale(data[1,5])
data<−na.omit(data)
set.seed(123)

size <- floor(0.8 * nrow(data))

train_ind <- sample(seq_len(nrow(data)), size = size)

train_labels <- data[train_ind,6]
test_labels <- row_labels[-train_ind]
data_train <- data[train_ind, 1:5]
data_test <- data[-train_ind,1:5]

library(class)

predictions <- knn(train = data_train,
                  test = data_test,
                  cl = train_labels,
                  k = round(sqrt(nrow(data_train))))

plot_predictions <- data.frame(
  data_test$gender,
  data_test$age,
  data_test$institution,
  data_test$city,
  data_test$userexperience,
  predicted = predictions
)


colnames(plot_predictions) <- c("gender","age", "city", "institution", "userexperience")

library(ggplot2)
library(gridExtra)

p1 <- ggplot(plot_predictions, aes(gender, age, color = predictions, fill = predictions)) + geom_point(size = 5) + geom_text(aes(label = test_labels),
                                                                                                                                       hjust = 1, vjust = 2) +
  ggtitle("Predicted relationship between Sepal Length and Width") + theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position = "none")
p1






