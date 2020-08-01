rm(list = ls())

library(rpart)

cancer <- read.csv("/home/i314/Desktop/DIPLO/Modulo 4 - Modelos Predictivos 1/Clase 4/Data/breast_cancer.csv", sep="," , header=TRUE)
head(cancer)

##Creo el Arbol
cancer_tree <- rpart( Class ~ Samplecodenumber + ClumpThickness + UniformityofCellSize + UniformityofCellShape + MarginalAdhesion + SingleEpithelialCellSize + BareNuclei + BlandChromatin + NormalNucleoli + Mitoses, method="class", data=cancer)

## Ver detalles del Arbol
summary(cancer_tree) 

##Visualizacion del arbol
plot(cancer_tree, uniform=TRUE, main="Classification Tree Cancer Breast")
text(cancer_tree, use.n=TRUE, all=TRUE, cex=.8)

##Se visualiza un Arbol de manera mas estetica
post(cancer_tree, file = "/home/i314/Desktop/DIPLO/Modulo 4 - Modelos Predictivos 1/Clase 4/Data/outputs/cancer_tree.ps",
   title = "Classification Tree for Cancer Breast")
   
## Podar el Arbol
prune_cancer_tree <- prune(cancer_tree, cp=cancer_tree$cptable[which.min(cancer_tree$cptable[,"xerror"]),"CP"])

## Visualizar el Arbol podado
plot(prune_cancer_tree, uniform=TRUE, main="Pruned Classification Tree for Cancer")
text(prune_cancer_tree, use.n=TRUE, all=TRUE, cex=.8)
post(prune_cancer_tree, file = "/home/i314/Desktop/DIPLO/Modulo 4 - Modelos Predictivos 1/Clase 4/Data/outputs/prune_cancer_tree.ps",
   title = "Pruned Classification Tree for Cancer")