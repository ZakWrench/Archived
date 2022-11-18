library(tidyverse) #works like ggplot2 library for plotting
library(broom) #Make models summary tidy
library(caret) #use to compute confusion matrix
library(visreg) #For plotting logodds and probabilities
library(margins) #used to calculate average Marginal Effects
library(rcompanion) #Used to calculate pseudo R2
library(ROCR) #Used to calculate Receiver Operating Curve



#Save data to Diabetes
lesdonnees <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\branchescientifique-wage-costofliving-merite-merite2-afford2.csv") #dataset for modeling
head(lesdonnees)
str(lesdonnees)

#Changing variable to "yes" -> 1 and "no" -> 0 
#levels(lesdonnees$INTEREST) <- 0:1

lesdonnees$afford1 <- as.factor(lesdonnees$afford1) #converting variable to factor of 2 levels so the algorithm can proceed without error, or use previous statement for conversion
lesdonnees$afford2 <- as.factor(lesdonnees$afford2)
#lesdonnees$afford3 <- as.factor(lesdonnees$afford3)
#lesdonnees$afford4 <- as.factor(lesdonnees$afford4)



head(lesdonnees)

#Dividing randomly data samples into train and test dataset#

set.seed(123) #setting random seed
index <- sample(2, nrow(lesdonnees), replace = TRUE, prob = c(0.7,0.3)) #obtaining the index 
train <- lesdonnees[index==1,] #obtaining train data
test <- lesdonnees[index == 2,] #obtaining test data
index #<-----
train
test


#Fitting a logistic regression model#

model_logi <-glm(afford2~., data = train, family = "binomial") #predicting binomial outcome
summary(model_logi) #statistics summary, glucose and pedigree being the significant independant variables <---- 

#Make data tidy using broom package
tidy(model_logi)


#Calculating important statistics#

#Calculating the odd ratio
(exp(coef(model_logi))) # extract the coef of model then apply exponent

#Logodds and probability plots

#Logodds of afford2 wrt to branch value
visreg(model_logi, "branch", xlab = "branch Value", ylab ="Log odds (afford2)") #how to logodds of afford2 changes in respect to the branch value

#Logodds of afford2 wrt to wage value
visreg(model_logi, "wage", xlab="tuition Value", ylab = "Log odds (afford2)") #how to logodds of afford2 changes in respect to the wage value

##Logodds of afford2 wrt to costliving value
visreg(model_logi, "costliving", xlab = "costliving Value", ylab ="Log odds (afford2)") #how to logodds of afford3 changes in respect to the thirdyw value

##Logodds of afford2 wrt to merite value
visreg(model_logi, "merite", xlab = "merite Value", ylab ="Log odds (afford2)") #how to logodds of afford3 changes in respect to the merite value


#Probabilities of afford2 wrt wage
visreg(model_logi, "wage", scale = "response", rug= 2, xlab = "wage value", ylab= "P(afford2)") # the line above and below represent the rug line

#Probabilities of afford2 wrt costliving
visreg(model_logi, "costliving", scale = "response", rug = 2, xlab = "costliving value", ylab = "P(afford2)")

#Probabilities of afford2 wrt merite
visreg(model_logi, "merite", scale = "response", rug = 2, xlab = "merite value", ylab = "P(afford2)")


#Calculate marginal effect#

#Marginal effects are also called instantaneous rates of change; you compute them for a variable while all other variabes are held constant.
#with discrete independent variables, marginal effects measure discrete change, that is how do predicted probabilities change as the binary independent variablechanges from 0 to 1?.
#Marginal effects for continuous variables measure the instantaneous rate of change. They are popular in some disciplines(for example Economics) because they often provide a good approximation to the amount of change in Y that will be produced by 1-unit change in Xk.
#There are two way of computing Marginal Effects: a)Marginal Effect at Mean b)Average Marginal Effect
#The magnitude of the marginal effect depends on the values of the other variables and their coefficients.
#The marginal Effect at Mean(MEM) is popular(that is compute the marginal effect when all x's are at their mean) but many think that Average Marginal Effects (AMEs) are superior

#using the margins library for Average Margin Effect compilation

#Calculate average marginal effect
effects_logit_dia = margins(model_logi)
print(effects_logit_dia)
summary(effects_logit_dia)

#plot marginal effect
plot(effects_logit_dia)

#plot marginal effect using ggplot2 library
effects_logit_diab = summary(effects_logit_dia)
ggplot(data = effects_logit_diab) + geom_point(mapping = aes(x = factor, y = AME)) + geom_errorbar(mapping = aes(x = factor, ymin = lower, ymax = upper)) +geom_hline(yintercept = 0) + theme_minimal() + theme(axis.text.x = element_text(angle = 45))

##Model Evaluation##

#Misclassification identification using confusion matrix
pred <- predict(model_logi, test, type = "response") #predict using test data
head(pred) #probabilities, next up we round it >0.5
predicted <- round(pred) #round of the value; >0.5 will convert to 1
head(predicted) # else 0

#Side by side comparison
head(data.frame(observed = test$afford2, predicted = predicted))

#Let's create a contigency table
tab <- table(predicted, test$afford2)
tab

sum(diag(tab))/sum(tab)*100 # percentage accuracy

#Confusion matrix using caret package
confusionMatrix(tab)


#calculating Pseudo R2 and loglikelyhood ratio test##

#using rcompanion library
nagelkerke(model_logi)


#Computation of the cutoff values

#using ROCR library

#use the prediction function to generate a prediction results

pred.rocr <- prediction(pred, test$afford2)
eval <- performance(pred.rocr, "acc")
plot(eval)

#Identify best value (Cutoff vs Accuracy)
eval
max <- which.max(slot(eval, "y.values")[[1]])
acc <- slot(eval, "y.values")[[1]][max] #y.values are accuracy measures
cut <- slot(eval, "x.values")[[1]][max] #x.values are cutoff measures

print(c(Accuracy = acc, Cutoff = cut))


##Receiver Operating Characteristic Curve computation

#using ROCR library

#ROC (Receiver Operating Characteristic) Curve tells us about how good the model can distinguish between two things

#Use the performance function to obtain the performance measurement:
perf.rocr <- performance(pred.rocr, measure = "auc", x.measure = "cutoff")
perf.rocr@y.values[[1]] <- round(perf.rocr@y.values[[1]], digits = 4)
perf.tpr.fpr.rocr <- performance(pred.rocr, "tpr", "fpr") #true positive rate/false negative rate

#pos (actual) --and-- predicted(pos) -> correctly identified -> true pos
#neg (actual) --and-- predicted(pos) -> incorrectly identified -> False pos
#pos (actual) --and-- predicted(not pos) -> incorrectly rejected -> false neg
#neg (actual) --and-- predicted(not pos) -> correctly rejected -> true neg

#Visualize ROC curve using plot function

plot(perf.tpr.fpr.rocr, colorize = T, main = paste("AUC:", (perf.rocr@y.values)))
abline(a=0, b=1)


########

