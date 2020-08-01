rm(list = ls())

library(rpart)

reg <- read.csv("C:\\DIPLOMATURA\\Modulo 8 - Arboles de Decision\\Clase 1\\Data\\house.csv", sep="," , header=TRUE)
head(reg)

##Metodo_ "anova"
reg_tree <- rpart(price ~ .,  method="anova", data=reg)
printcp(reg_tree)
plotcp(reg_tree)
summary(reg_tree)

plot(reg_tree, uniform=TRUE, main="Regression Tree for House Pricing") 
text(reg_tree, use.n= TRUE)

post(reg_tree, file = "C:\\DIPLOMATURA\\Modulo 8 - Arboles de Decision\\Clase 1\\Data\\ptree.ps",
   title = "Pruned Classification Tree for House Pricing")



