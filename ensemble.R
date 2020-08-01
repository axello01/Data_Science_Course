# https://www.analyticsvidhya.com/blog/2017/02/introduction-to-ensembling-along-with-implementation-in-r/
  
rm(list = ls())

library('caret')
library('RANN')

data <- read.csv(url('https://datahack-prod.s3.ap-south-1.amazonaws.com/train_file/train_u6lujuX_CVtuZ9i.csv'))

#Does the data contain missing values
sum(is.na(data))

#Imputing missing values using median
preProcValues <- preProcess(data, method = c("medianImpute","center","scale"))
data_processed <- predict(preProcValues, data)

sum(is.na(data_processed))

#Spliting training set into two parts based on outcome: 75% and 25%
index <- createDataPartition(data_processed$Loan_Status, p=0.75, list=FALSE)
trainSet <- data_processed[ index,]
testSet <- data_processed[-index,]

#Defining the training controls for multiple models
fitControl <- trainControl(
  method = "cv",
  number = 5,
  savePredictions = 'final',
  classProbs = T)

#Defining the predictors and outcome
predictors <- c("Credit_History", "LoanAmount", "Loan_Amount_Term", "ApplicantIncome", "CoapplicantIncome")
outcomeName <- 'Loan_Status'

###########################################################################
########### START MODELS ##################################################

######### 1. Random Forest ################################################
model_rf <- train(trainSet[,predictors],trainSet[,outcomeName],method='rf',trControl=fitControl,tuneLength=3)
#Predicting using random forest model
testSet$pred_rf <- predict(object = model_rf,testSet[,predictors])
#Checking the accuracy of the random forest model
confusionMatrix(testSet$Loan_Status,testSet$pred_rf)

######### 2. KNN ################################################
model_knn<-train(trainSet[,predictors],trainSet[,outcomeName],method='knn',trControl=fitControl,tuneLength=3)
#Predicting using knn model
testSet$pred_knn<-predict(object = model_knn,testSet[,predictors])
#Checking the accuracy of the random forest model
confusionMatrix(testSet$Loan_Status,testSet$pred_knn)

######### 2. Logistic Regression ################################################
model_lr<-train(trainSet[,predictors],trainSet[,outcomeName],method='glm',trControl=fitControl,tuneLength=3)
#Predicting using knn model
testSet$pred_lr <- predict(object = model_lr,testSet[,predictors])
#Checking the accuracy of the random forest model
confusionMatrix(testSet$Loan_Status,testSet$pred_lr)

###########################################################################
############# END MODELS ##################################################

#Predicting the probabilities
testSet$pred_rf_prob <- predict(object = model_rf,testSet[,predictors],type='prob')
testSet$pred_knn_prob <- predict(object = model_knn,testSet[,predictors],type='prob')
testSet$pred_lr_prob <- predict(object = model_lr,testSet[,predictors],type='prob')

#Taking average of predictions
testSet$pred_avg <- (testSet$pred_rf_prob$Y+testSet$pred_knn_prob$Y+testSet$pred_lr_prob$Y)/3
#Splitting into binary classes at 0.5
testSet$pred_avg <- as.factor(ifelse(testSet$pred_avg>0.5,'Y','N'))

#The majority vote
testSet$pred_majority <- as.factor(ifelse(testSet$pred_rf=='Y' & testSet$pred_knn=='Y','Y',
                                        ifelse(testSet$pred_rf=='Y' & testSet$pred_lr=='Y','Y',ifelse(testSet$pred_knn=='Y' & testSet$pred_lr=='Y','Y','N'))))

#Taking weighted average of predictions
testSet$pred_weighted_avg <- (testSet$pred_rf_prob$Y*0.25)+(testSet$pred_knn_prob$Y*0.25)+(testSet$pred_lr_prob$Y*0.5)

#Splitting into binary classes at 0.5
testSet$pred_weighted_avg <- as.factor(ifelse(testSet$pred_weighted_avg>0.5,'Y','N'))

#########################################################################################################
#########################################################################################################

