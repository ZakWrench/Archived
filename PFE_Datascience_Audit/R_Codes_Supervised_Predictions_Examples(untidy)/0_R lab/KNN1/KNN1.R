library(class)
library(caret)


dataset.subset <- read.csv("C:\\Users\\sofia noussi\\Desktop\\csv\\Final\\Final - relabeling - Copy - Copy.csv")

#Import the dataset
head(dataset.subset)

#Normalization
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) }

dataset.subset.n <- as.data.frame(lapply(dataset.subset[,1:9], normalize))
head(dataset.subset.n)

set.seed(123)
dat.d <- sample(1:nrow(dataset.subset.n),size=nrow(dataset.subset.n)*0.7,
                replace = FALSE) #random selection of 70% data.

train.dataset <- dataset.subset[dat.d,] # 70% training data
test.dataset <- dataset.subset[-dat.d,] # remaining 30% test data

#Creating seperate dataframe for 'interest' feature which is our target.
train.dataset_labels <- dataset.subset[dat.d,9]
test.dataset_labels <- dataset.subset[-dat.d,9]

# Load class package

#Find the number of observation
NROW(train.dataset_labels)
sqrt(177)
#So, we have 35000 observations in our training data set. The square root of 35000 is around 13.0829,
#therefore we’ll create two models. One with ‘K’ value as 13 and the other model with a ‘K’ value as 12.

knn.13 <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=13)
knn.12 <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=12)

#Calculate the proportion of correct classification for k = 13, 12
ACC.13 <- 100 * sum(test.dataset_labels == knn.13)/NROW(test.dataset_labels)
ACC.12 <- 100 * sum(test.dataset_labels == knn.12)/NROW(test.dataset_labels)

#ACC.13
#[1] 77.82667
#ACC.12
#[1] 77.93333

#As shown above, the accuracy for K = 13 is 77.82 and for K = 27 it is 77.93. We can also check the predicted outcome against the actual value in tabular form:

# Check prediction against actual value in tabular form for k=13
table(knn.13 ,test.dataset_labels)

# Check prediction against actual value in tabular form for k=12
table(knn.12 ,test.dataset_labels)

confusionMatrix(table(knn.13 ,test.dataset_labels))
confusionMatrix(table(knn.12 ,test.dataset_labels))


#optimization
i=1
k.optm=1
for (i in 1:20){
  knn.mod <- knn(train=train.dataset, test=test.dataset, cl=train.dataset_labels, k=i)
  k.optm[i] <- 100 * sum(test.dataset_labels == knn.mod)/NROW(test.dataset_labels)
  k=i
  cat(k,'=',k.optm[i],'')
}

#Accuracy plot
plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")

