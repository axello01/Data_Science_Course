#load required library (assuming e1071 is already loaded)
library(mlbench)
#load Sonar dataset
data(Sonar)
#set seed to ensure reproducible results
set.seed(42)
#split into training and test sets
Sonar[,"train"] <- ifelse(runif(nrow(Sonar))<0.8,1,0)
#separate training and test sets
trainset <- Sonar[Sonar$train==1,]
testset <- Sonar[Sonar$train==0,]
#get column index of train flag
trainColNum <- grep("train",names(trainset))
#remove train flag column from train and test sets
trainset <- trainset[,-trainColNum]
testset <- testset[,-trainColNum]
#get column index of predicted variable in dataset
typeColNum <- grep("Class",names(Sonar))
#build model – linear kernel and C-classification with default cost (C=1)
svm_model <- svm(Class~ ., data=trainset, method="C-classification", kernel="linear")
#training set predictions
pred_train <-predict(svm_model,trainset)
mean(pred_train==trainset$Class)
#test set predictions
pred_test <-predict(svm_model,testset)
mean(pred_test==testset$Class)

#####################################################################
svm_model <- svm(Class~ ., data=trainset, method="C-classification", kernel="radial")
#print params
svm_model$cost
svm_model$gamma
#training set predictions
pred_train <-predict(svm_model,trainset)
mean(pred_train==trainset$Class)
#test set predictions
pred_test <-predict(svm_model,testset)
mean(pred_test==testset$Class)

#######################################################################
tune_out <- tune.svm(x=trainset[,-typeColNum],y=trainset[,typeColNum],gamma=10^(-3:3),cost=c(0.01,0.1,1,10,100,1000),kernel="radial")
#print best values of cost and gamma
tune_out$best.parameters$cost
tune_out$best.parameters$gamma
#
svm_model <- svm(Class~ ., data=trainset, method="C-classification", kernel="radial",cost=tune_out$best.parameters$cost,gamma=tune_out$best.parameters$gamma)
#training set predictions
pred_train <-predict(svm_model,trainset)
mean(pred_train==trainset$Class)
pred_test <-predict(svm_model,testset)
mean(pred_test==testset$Class)


C:/Users/Graciela/Desktop/Diplo Data Science/Clase_1_Septiembre
