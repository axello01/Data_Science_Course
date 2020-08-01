rm(list=ls())

library(e1071)
data(iris)

cm_model <- cmeans(iris[,-5], 3, 100, 1, method="cmeans")
plot(iris[,1], iris[,2], col=cm_model$cluster)

set.seed(1)
K <- kmeans(iris[,-5], centers = 2, iter.max = 50)
