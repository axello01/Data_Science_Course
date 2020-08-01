#################
# 1. VECTORES
#################
#Los vectores puede crearse con la función c()

x <- c(0.1, 0.2)               ## Numérico
y <- c(TRUE, FALSE)     	   ## Lógico
t <- c(“a”, “b”, “c”)          ## Character
z <- c(1+0i, 2+4i)             ## Complejo

# 1.1 class

x <- c(0.1, 0.2)               
class(x)

y <- c(TRUE, FALSE)     
class(y)

t <- c("a", "b", "c")  
class(t)

# 1.2 Suma de vectores

aa <- c(1, 2, 3)
bb <- c(10, 1, 0)
cc <- (aa + bb)
cc

# 1.3 Orden y Recorrido de un vector
v <- c(11,2,0,1,10,43,3)
v1 <- sort(v)
sort(v,decreasing = TRUE)
### También podemos recorrer un vector:
v[4]  
length(v) # Nos muestra la cantidad de elementos en el vector 

#################
# 2. MATRICES
#################
# Las matrices en R pueden ser vistas como vectores con un atributo de dimensión.
matriz <- matrix(nrow = 2, ncol = 3)
dim(matriz)
# Si las matrices las cargamos a mano, hay que tener en cuenta que se van llenando por COLUMNAS primero.
matriz <- matrix(1:6, nrow = 2, ncol = 3)

##Dos funciones que serán sumamente útiles a la hora de crear matrices son:
## “cbind” y “rbind”, las cuales construyen matrices a partir de vectores, ya sea por columnas (cbind) o filas (rbind)

x <- c(1:4)
y <- c(20, 22, 24, 26 )
cbind(x, y)
rbind(x, y)

#################
# 3. DATAFRAMES
#################
# Es el tipo de datos más importante de R. Son usados para guardar tablas formadas por vectores de la misma longitud. 
a <- c(1, 2, 3)
b <- c("a", "b", "c")
c <- c(TRUE, FALSE, FALSE)
data_set <- data.frame(a, b, c)
data_set

# 3.1 Recorrer DATAFRAMES
mtcars #dataframe que viene instalado por defecto en el core de R.
class(mtcars)
mtcars[1,2] 
nrow(mtcars)
ncol(mtcars)
head(mtcars)
tail(mtcars)
summary(mtcars)

# 3.2 Construyendo un dataset:

nombre <- c("Juan","Maria","Pedro","Ana")
edad <- c(21,34,42,23)
genero <- c("Masculino","Femenino","Masculino","Femenino")

data_set <- as.data.frame(cbind(nombre,edad,genero))

#####################################
# 4. ESTRUCTURAS DE CONTROL #########
#####################################
# 4.1 FOR
x <- c(5,12,13)
for (n in x)
{
print(n^2)
}

# 4.2 IF - elementos
x <- 9
if(x > 9) {
	    print("x is larger than 9")
} else {
        print("x es menor o igual a 9")
}

# 4.3 IF ANIDADO
x <- 1
if(x > 9) { 
print("x es mayor a 9")
} else if(x > 7) { 
print("x es mayor a 7, pero no mayor a  9")
} else { 
print("x es menor a 7") }

#4.4 WHILE
limite <- 20

n <- 0
s <- 0
while(s < limite) {

n <- n + 1
s <- s + n

}
resultado <- c(n, s)
resultado

#####################################
# 5. FUNCIONES ######################
#####################################

f <- function(a) {
a^2
}
f(2)


#################################

# juan.brana@gmail.com

