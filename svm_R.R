library(e1071)

x <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
y <- c(3,4,5,4,8,10,10,11,14,20,23,24,32,34,35,37,42,48,53,60)

#Create a data frame of the data
train <- data.frame(x,y)

plot(train,pch=16)

#Linear regression
model <- lm(y ~ x, train)

#Plot the model using abline
abline(model)

## SVM model
model_svm <- svm(y ~ x , train)
pred <- predict(model_svm, train)

points(train$x, pred, col = "blue", pch=4)

## LM Error -> RMSE
error <- model$residuals
lm_error <- sqrt(mean(error^2))

## SVM Error 
error_2 <- train$y - pred
svm_error <- sqrt(mean(error_2^2)) 

#####
## We can specify the values for the cost parameter and epsilon which is 0.1 by default. A simple way is to try for each 
## value of epsilon between 0 and 1 (I will take steps of 0.01) and similarly try for cost function from 4 to 2^9 
## (I will take exponential steps of 2 here). I am taking 101 values of epsilon and 8 values of cost function. 
## I will thus be testing 808 models and see which ones performs best. The code may take a short while to run all the models 
## and find the best version. The corresponding code will be:

svm_tune <- tune(svm, y ~ x, data = train,
                 ranges = list(epsilon = seq(0,1,0.01), cost = 2^(2:9))
)
print(svm_tune)

## The root-mean-square deviation (RMSD) or root-mean-square error (RMSE) is a frequently used measure of the differences 
## between values (sample and population values) predicted by a model or an estimator and the values actually observed. 
## The RMSD represents the sample standard deviation of the differences between predicted values and observed values. 
## These individual differences are called residuals when the calculations are performed over the data sample that was used for 
## estimation, and are called prediction errors when computed out-of-sample. 