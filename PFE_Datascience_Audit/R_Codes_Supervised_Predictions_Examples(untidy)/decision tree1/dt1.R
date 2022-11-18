#Prepare data
data <- Cardiotocographic
str(data)
data$NSPF <- factor(data$NSP)
set.seed(1234)
pd <- sample(2, nrow(data), replace = TRUE, prob = c(0.8,0.2))
train <- data[pd==1,]
validate <- data[pd==2,]
library(party)

tree <- ctree(NSPF~LB+AC+FM, data = train, controls = ctree_control(mincriterion=0.99,minsplit=500))
tree
plot(tree)

#predict
predict(tree, validate, type="prob")
predict(tree, validate)

library(rpart)
tree1 <- rpart(NSPF~LB+AC+FM, train)
library(rpart.plot)
rpart.plot(tree1)
#rpart.plot(tree1, extra=4)

#more predictions
predict(tree1, validate)

#Misclassification error with validate data
tab <- table(predict(tree), train$NSPF)
print(tab)
1-sum(diag(tab))/sum(tab)

#Misclassification error with validate data
testPred <- predict(tree, newdata = validate)
tab <- table(testPred,validate$NSPF)
print(tab)
1-sum(diag(tab))/sum(tab)

















