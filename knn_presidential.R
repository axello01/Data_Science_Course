rm(list = ls())

library(caret)
library(e1071)

data.presidential <- read.csv("/home/i314/Desktop/DIPLO/Clase_15_Septiembre/US_Presidential_Data.csv", header = T, sep=",")
data.presidential$Win.Loss = as.factor(data.presidential$Win.Loss)

rand_index <- createDataPartition(data.presidential$Win.Loss, p = 0.7, list = F)

data.presidential.train <- data.presidential[rand_index,]
data.presidential.test  <- data.presidential[-rand_index,]

levels(data.presidential.train$Win.Loss) <- make.names(levels(factor(data.presidential.train$Win.Loss)))

levels(data.presidential.test$Win.Loss)  <- make.names(levels(factor(data.presidential.test$Win.Loss)))

repeats <- 3
numbers <- 10
tunel <- 10

x_control <- trainControl(method = "repeatedcv",
                 repeats = repeats,          
                 number = numbers,
                 classProbs = TRUE,
                 summaryFunction = twoClassSummary)

model_knn <- train(Win.Loss~. , data = data.presidential.train, method = "knn",
                preProcess = c("center","scale"),
                trControl = x_control,
                metric = "ROC",
                tuneLength = tunel)

model_knn
plot(model_knn)
