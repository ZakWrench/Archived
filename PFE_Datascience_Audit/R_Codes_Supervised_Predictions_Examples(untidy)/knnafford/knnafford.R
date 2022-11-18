dataset <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\Knn\\wageafford2.csv", header = TRUE)
dataset.subset <- read.csv("C:\\Users\\Fatihi\\Desktop\\data\\1LAB\\DataFinal\\Knn\\wageafford2.csv", header = TRUE)

#Import the dataset
head(dataset.subset)

#Normalization
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) }

dataset.subset.n <- as.data.frame(lapply(dataset.subset[,1:8], normalize))
head(dataset.subset.n)

set.seed(123)
dat.d <- sample(1:nrow(dataset.subset.n),size=nrow(dataset.subset.n)*0.7,replace = FALSE) #random selection of 70% data.

train.dataset <- dataset.subset[dat.d,] # 70% training data
test.dataset <- dataset.subset[-dat.d,] # remaining 30% test data

#Creating seperate dataframe for 'interest' feature which is our target.
train.dataset_labels <- dataset.subset[dat.d,9]
test.dataset_labels <- dataset.subset[-dat.d,9]

# Load class package
library(class)

#Find the number of observation
NROW(train.dataset_labels)
sqrt(35000)
#So, we have 700 observations in our training data set. The square root of 35000 is around 187.0829,
#therefore we’ll create two models. One with ‘K’ value as 187 and the other model with a ‘K’ value as 186.

knn.187 <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=187)
knn.186 <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=186)

#Calculate the proportion of correct classification for k = 187, 186
ACC.187 <- 100 * sum(test.dataset_labels == knn.187)/NROW(test.dataset_labels)
ACC.186 <- 100 * sum(test.dataset_labels == knn.186)/NROW(test.dataset_labels)

#ACC.187
#[1] 77.82667
#ACC.186
#[1] 77.93333

#As shown above, the accuracy for K = 187 is 77.82 and for K = 27 it is 77.93. We can also check the predicted outcome against the actual value in tabular form:

# Check prediction against actual value in tabular form for k=187
table(knn.187 ,test.dataset_labels)

# Check prediction against actual value in tabular form for k=186
table(knn.186 ,test.dataset_labels)

library(caret)

confusionMatrix(table(knn.187 ,test.dataset_labels))



i=1
k.optm=1
for (i in 1:187){
  knn.mod <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=i)
  k.optm[i] <- 100 * sum(test.dataset_labels == knn.mod)/NROW(test.dataset_labels)
  k=i
  cat(k,'=',k.optm[i],'')
}

#Accuracy plot
plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")
