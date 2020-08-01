library(ElemStatLearn)
library(FSelector)

### Ejemplo 01
head(SAheart)

#Transformo a FRACTOR, de lo contrario RandomForest intentara realizar una REGRESION!
SAheart$chd <- as.factor(SAheart$chd)

selection <- random.forest.importance(chd ~ ., SAheart)

#Funciones especificas de random.forest.importance
cutoff.biggest.diff(selection)
cutoff.k(selection, k = 4)

## Ejemplo 02 (Se encuentra en la documentacion de random.forest.importance)
library(mlbench)

data(HouseVotes84)



weights <- random.forest.importance(Class~., HouseVotes84, importance.type = 1)
print(weights)
subset <- cutoff.k(weights, 5)
f <- as.simple.formula(subset, "Class")
print(f)


library(ElemStatLearn)

head(SAheart)

summary(SAheart)




