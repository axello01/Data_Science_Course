rm(list=ls())


#install.packages("ElemStatLearn")
#install.packages("caret")
#install.packages("klaR")
library(ElemStatLearn)
library(klaR)
library(caret)

#Mezclamos el set de datos, reservando el 90% para training, y 10% para testing
data <- sample(nrow(spam), floor(nrow(spam) * 0.9))
train <- spam[data,]
test = spam[-data,]

atributos_train <- train[,-58]
target_train <- train$spam

atributos_test <- test[,-58]
target_test <- test$spam

model = train(atributos_train,target_train,'nb',trControl=trainControl(method='cv',number=10))

table(predict(model$finalModel,atributos_test)$class,target_test)
