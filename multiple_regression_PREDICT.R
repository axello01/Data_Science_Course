## Cargo el set de datos. 
## Chequear el PATH donde se encuentra guardado el de set de datos de entrenamiento.

training <- read.csv("/home/i314/Desktop/DIPLO/2016/Modulo_1/Clase_3/DATA_SETS/Regresion_Multiple_training.csv",header=T,sep=',')
head(training)

## Solo considero las columnas de la 2 a la 5
## Quito la primera variable (PERIODO), ya que habiamos determinado que no aportaba ningun tipo de informacion
data_training <- training[,2:5]
head(data_training)

## Creo el modelo de Regresion Lineal
## ENROL es la variable dependiente, y para no escribir una por una las variables independientes, se usa el "." (punto)
training_lm <- lm(data_training$ENROL ~ ., data=data_training)
summary(training_lm)
training_lm

## Obtenemos el Siguiente Modelo:
##  -9263.1450 + 502.94*DESEMPLEO + 0.4574*GRADUADOS + 3.8411*INGRESOS
## En nuestro testing set: DESEMPELO=7, GRADUADOS=16816, INGRESOS=3345
## Por lo cual la prediccion de ENROL es: 14797

## Vamos a importar el set de datos de training

testing <- read.csv("/home/i314/Desktop/DIPLO/2016/Modulo_1/Clase_3/DATA_SETS/Regresion_Multiple_testing.csv",header=T,sep=',')
head(testing)    

## Quito nuevamente la columna PERIODO, y tambien quito la columna ENROL, ya que esta justamente es la que deseo PREDECIR)

testing_data <-testing[,3:5]
head(testing_data)

## Uso el poderoso comando "predict" para realizar tal prediccion, usando el modelo generado "training_lm" y el set de datos 
## que deseo predecir "testing_data"

predict(training_lm, testing_data)

## La prediccion que arroja es de: "14798"
## El valor verdadero (lo conozco!) fue de: "16081"

## Puedo ver el intervalo de confianza del 95%
predict(training_lm, testing_data, interval="predict")

## El resultado es el siguiente:
##       fit      lwr      upr
## 1 14797.98 13246.99 16348.97
## Esto se lee: La prediccion es de: 14797, y el valor va a estar entre 13.247 y 16349 con una confianza del 95%