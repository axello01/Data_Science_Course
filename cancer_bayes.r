rm(list=ls())
#install.packages("ElemStatLearn")
#install.packages("caret")
#install.packages("klaR")
#install.packages("gdata")
library(ElemStatLearn)
library(klaR)
library(caret)
library(gdata)


cancer_data <- read.xls("/Data/SURVIVAL-TRAIN.xls",header=T)
cancer_predict <- read.xls("/Data/SURVIVAL-TEST.xls",header=T)

#Mezclamos el set de datos, reservando el 90% para training, y 10% para testing
data <- sample(nrow(cancer_data), floor(nrow(cancer_data) * 0.9))
train <- cancer_data[data,]
test <- cancer_data[-data,]

train <- train[-1]
test <- test[-1]

atributos_train <- train[,-15]
target_train <- train$Vital.status.recode..study.cutoff.used.

atributos_test <- test[,-15]
target_test <- test$Vital.status.recode..study.cutoff.used.

model <- train(atributos_train,target_train,'nb',trControl=trainControl(method='cv',number=10))

table(predict(model$finalModel,atributos_test)$class,target_test)
