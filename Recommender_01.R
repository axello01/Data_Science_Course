rm(list=ls())
library("recommenderlab")

data("MovieLense")

#Busco Usuarios que hayan clasificado al menos 100 peliculas, o sea que hayan recomendado mas de 100 veces
MovieLense100 <- MovieLense[rowCounts(MovieLense) >100,]
train <- MovieLense100[1:50]

### learn user-based collaborative filtering recommender
rec <- Recommender(train, method = "UBCF")
rec

### Crear las mejores N (en este caso 10) recommendations para nuevos usuarios 
pre <- predict(rec, MovieLense100[103:106], n = 5)
pre

## Paso a Lista
as(pre, "list")

##############################################
########## https://www.r-bloggers.com/recommender-systems-101-a-step-by-step-practical-example-in-r/
########## Step by Step Practical Example in R.
##############################################
########## https://www.r-bloggers.com/testing-recommender-systems-in-r/
########## Testing Recommender Systems in R
##############################################