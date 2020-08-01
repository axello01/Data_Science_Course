C:/Users/Graciela/Desktop/Diplo Data Science/22 sept/Directorio
C:/Users/Graciela/Desktop/Diplo Data Science/Library


library("adabag")
data("iris")

train <- c(sample(1:50, 25), sample(51:100, 25), sample(101:150, 25))

iris.adaboost <- boosting(Species ~ ., data = iris[train, ], mfinal = 10, control = rpart.control(maxdepth = 1))

iris.adaboost$votes
iris.adaboost$importance
iris.adaboost$class

table(iris.adaboost$class, iris$Species[train], dnn = c("Predicted Class", "Observed Class"))

iris.predboosting <- predict.boosting(iris.adaboost, newdata = iris[-train, ])
iris.predboosting
iris.predboosting$confusion

#aca haces cross validation

iris.boostcv <- boosting.cv(Species ~ ., v = 10, data = iris, mfinal = 10, control = rpart.control(maxdepth = 1))
iris.boostcv$confusion

######################################

iris.bagging <- bagging(Species ~ ., data = iris[train, ], mfinal = 10, control = rpart.control(maxdepth = 1))
iris.bagging$votes

table(iris.bagging$class, iris$Species[train], dnn = c("Predicted Class", "Observed Class"))

iris.predbagging <- predict.bagging(iris.bagging, newdata = iris[-train, ])
iris.predbagging$confusion

