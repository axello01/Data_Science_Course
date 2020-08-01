## Instalo el paquete "e1071" que contiene el algoritmo NaiveBayes 
install.packages("e1071")

## Cargo las librerias que acabo de instalar
library(e1071)

## Cargo el set de datos "iris", ya es parte del core de R, no hay falta importarlo
attach(iris)
head(iris)

## Creo el modelo NaiveBayes
modelo_bayes <- naiveBayes(iris[,1:4], iris[,5]) 

## Creo la matriz de confusion
table(predict(modelo_bayes, iris[,-5]), iris[,5])