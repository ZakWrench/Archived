library(dataPreparation) #Do most of the painful data prep with minimun amount of code, take adv of 'data.table' efficiency and perform some algorithmic tricks to perform data prep in a time and Ram the efficient way
library(mlbench) #Collection of artificial and real-world ml benchmark problems, including several data set from UCI repo
library(e1071)#Functions for laten class analysis, short time Fourier Transform, fuzzy clustering, SVM, Shortest path computation, bagged clustering, naive Bayes classifier, generalized Knn
library(caret)#Misc functions for training and plotting classification and regression models.
library(ROCR)#ROC graphs, sensitivity/specificity curves, lift charts, precision/recall plots, creation cutoff-parametrized 2D performance curves by freely combining two from over 25 performance measures(new performance measures can be added using standard interface)
library(kernlab)#kernel-based ML for classification,regression, clusetering, novelty detection, quantile regression and dimensionality reduction, also include SVM, Spectral Vlustering, Kernel PCA, Gaussian Processes and QP solver.
library(dplyr)#Grammar for data manipulation, a fast and consisten tool for working with data frame like objects, both in memory and out of memory.
library(ggplot2)#Create elegant data cisualisations using the Grammar of Graphics, a system for declaratively creating graphics, based on the Grammar of Graphics. By providing the data,we tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.
library(corrplot)#Provide a visual exploratory tool on correlation matrix that supports automatic variable reordering to help detect hidden patterns among variables.



OJ <- read.csv(url("http://data.mishra.us/files/OJ.csv"))

str(OJ)
summary(OJ)
lapply(OJ,class)


OJ <- OJ %>% #Data cleaning, FActorizing categorical variable along with Recoding MM/CH in OJ dataset
  mutate(Purchase = recode_factor(Purchase, "MM"= "Y", "CH" = "NN"),
         StoreID = factor(StoreID),
         SpecialCH = factor(SpecialCH),
         SpecialMM = factor(SpecialMM),
         Purchase = factor(Purchase)
         )

lapply(OJ,class) #rechecking datatype of vars

sessionInfo()#Check versioning of packages being loaded
constant_cols <- which_are_constant(OJ) #Identifying and listing variables that are constants
double_cols <- which_are_in_double(OJ)#Ident the var that are double
bijections_cols <- which_are_bijection(OJ)#Ident the vars that are exact Bijections
OJ <- OJ[,-18] 
included <- which_are_included(OJ)#Ident and list vars that are exact included

#Remove all constant, Doubles, Bijections and Included 

OJ <- OJ[,-14]
OJ <- OJ[,-7]
OJ <- OJ[,-6]

str(OJ)#Check for highly correlated variables amongst numeric variables
OJ_numeric <- OJ[,c(4,5,8,9,10,11,12,13,14)]
res <- cor(OJ_numeric)
round(res,2)
res <- cor(OJ_numeric)
round(res,2)

#Corresponing graph points out the values whichare closer to 1 or -1 which are highly correlated and we can remove them from our model
corrplot(res, method="ellipse")

OJ <- OJ[,-14]
OJ <- OJ[,-11]
OJ <- OJ[,-10]
OJ <- OJ[,-9]

#Mis-classified

OJ <- OJ[,-2] #didnt appear on the graph

#Train and test data

split = .8
set.seed(99894)

#Data split into train / test(holdout)

train_index <- sample(1:nrow(OJ), split * nrow(OJ)) # 80% of data randomly selected for train data
test_index <- setdiff(1:nrow(OJ), train_index) # The remaining 20% of the data is used for holdout testing

X_train_unscaled <- OJ[train_index, -1]
y_train <- OJ[train_index,1]

X_test_unscaled <- OJ[test_index, -1]
y_test <- OJ[test_index, 1]

#Data is standardized and encoded

#Continuous variables

scales <- build_scales(data_set= X_train_unscaled, cols = "auto", verbose = FALSE)
X_train <- fast_scale(data_set = X_train_unscaled, scales = scales, verbose = FALSE)
X_test <- fast_scale(data_set = X_test_unscaled, scales = scales, verbose = FALSE)

#Encoding Categorical Variables 

encoding <- build_encoding(data_set = X_train, cols = "auto", verbose = FALSE)
X_train <- one_hot_encoder(data_set = X_train, encoding = encoding, drop = TRUE, verbose = FALSE)
X_test <- one_hot_encoder(data_set = X_test, encoding = encoding, drop = TRUE, verbose = FALSE)

#Creating one data frame using both Outcome and Predictor Variables

train_Data <- cbind(y_train, X_train)
test_Data <- cbind(y_test, X_test)

#Determining important variables based on P-value
scale <- build_scales(data_set = OJ, verbose = TRUE)

OJ_2 <- fast_scale(data_set = OJ, scales = scale, verbose = TRUE)

predictionModel <- glm(Purchase ~ ., data= OJ_2, family = binomial(link = 'logit'))

summary(predictionModel)$coefficients


Model1 <- glm(Purchase ~ ., data = OJ_2, family = binomial(link = "logit"))
Model2 <- glm(Purchase ~ StoreID + PriceCH + PriceMM + LoyalCH + PctDiscMM + PctDiscCH, data = OJ_2, family = binomial(link = "logit"))

#Printing the AIC value for each model

print(paste("Model 1: ", AIC(Model1), "Model 2: ", AIC(Model2)))

#Logit Model

logitmodel <- glm(Purchase ~ PriceCH + PriceMM + LoyalCH + PctDiscMM + PctDiscCH + StoreID.1 + StoreID.2 + StoreID.3 + StoreID.4, data = train_Data, family = binomial(link = 'logit'))

#Predict 
X_test$pred <- predict(logitmodel, newdata = X_test, type ="response")

#Converting probabilities into Categorical Predictions

X_test$binart_pred <- ifelse(X_test$pred < 0.55, "Y", "N")
X_test$binary_pred <- as.factor(X_test$binary_pred)

#Confusion Matrix

confusionMatrix(data = X_test$binary_pred, as.factor(y_test$Purchase))
confusionMatrix(data = X_test$binary_pred, as.factor(y_test$Purchase))
