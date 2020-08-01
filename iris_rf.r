library(randomForest)


# Mezclo el set de datos Iris
iris_2 <- iris[sample(nrow(iris)),]

# Divido el set de datos en Training y Testing
test = iris_2[ c(1:30), ]
train = iris_2[ c(31:150), ]

# Creo el modelo basado en Random Forest
iris_rf <- randomForest(Species ~., data=train, importance=TRUE, do.trace=50, ntree=100)
 
 print(iris_rf)
 plot(iris_rf)
 importance(iris_rf)
 
# Realizo la prediccion

iris_rf_pred <- predict(iris_rf, test) 
iris_rf_pred

t <- table(observed=test[,'Species'], predict=iris_rf_pred)
t

########
########
#### TUNING

mtry <- tuneRF(iris[, -5], iris[, 5], mtryStart = 1, stepFactor = 2, ntreeTry = 500, improve = 0.01)
iris_rf <- randomForest(Species ~., data=train, importance=TRUE, do.trace=50, ntree=1000, mtry=2)
