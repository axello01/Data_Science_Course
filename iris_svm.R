library(e1071)
#load built-in iris dataset
data(iris)
#set seed to ensure reproducible results. para que el experimento sea reproducible, todos vamos a tener el mismo set de datos
set.seed(42)
#split into training and test sets
iris[,"train"] <- ifelse(runif(nrow(iris))<0.8,1,0)
#separate training and test sets
trainset <- iris[iris$train==1,]
testset <- iris[iris$train==0,]
#get column index of train flag
trainColNum <- grep("train",names(trainset))
#remove train flag column from train and test sets
trainset <- trainset[,-trainColNum]
testset <- testset[,-trainColNum]
#get column index of predicted variable in dataset
typeColNum <- grep("Species",names(iris))
#build model – linear kernel and C-classification (soft margin) with default cost (C=1)
svm_model <- svm(Species~ ., data=trainset, method="C-classification", kernel="linear")
svm_model
svm_model$SV #(show the supports)

#training set predictions
pred_train <-predict(svm_model,trainset)
mean(pred_train==trainset$Species)

pred_test <-predict(svm_model,testset)
mean(pred_test==testset$Species)
