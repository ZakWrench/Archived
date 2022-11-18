train <- train[, 2:9]
summary(train)
unique(train$Profession)
train[train == ""] <- NA
train <- train[complete.cases(train), ]
library(dplyr)
dataset <- train %>% select_if(is.numeric)
character <- train %>% select_if(is.character)
library(fastDummies)
character <- dummy_cols(character, remove_most_frequent_dummy = TRUE)
#finalize dataset
dataset <- cbind(dataset, character[, 6:18])
#scale dataset
dataset[, 1:16] <- scale(dataset[, 1:16])
#determining the amount of segments
library(factoextra)
dataset <- na.omit(dataset)
fviz_nbclust(dataset, kmeans, method = "wss") + labs(subtitle = "Elbow Method")
#cluster
clusters <-kmeans(dataset, center = 6, iter.max = 10)
clusters$centers
dataset <- cbind(dataset, clusters$cluster)
write.csv(clusters$centers, file = "clusters.csv")







