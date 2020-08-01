rm(list = ls())
##Cargamos el archivo csv: "nba.csv". Recordar dar el path correcto
nba <- read.csv("/home/i314/Desktop/DIPLO/Modulo 5 - Modelos de Segmentacion/Clase 3/nba.csv", sep=",",header=T)

##Ordenamos el set datos de mayor a menor, de acuerdo a la cantidad de puntos anotados.
##Podrían elegir cualquier otra variable
nba <- nba[order(nba$PTS),]

##Extraemos la columna de los nombres de los jugadores para dar luego formato al mapa
##Usar la funcion row.names()

row.names(nba) <- nba$Name
nba <- nba[,-1]

##Creamos una matriz de datos

nba_matrix <- data.matrix(nba)

##Creamos los mapas de calor

nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = cm.colors(256), scale="column")

##Con diferentes gamas de colores
nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = heat.colors(256), scale="column")


##Probamos ordenar por otra variable
nba <- nba[order(-nba$FTP),]
nba_matrix <- data.matrix(nba)
nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA, col = heat.colors(256), scale="column", margins=c(5,10))

?cm.colors


# Ver ejemplo con mtcars
#http://digitheadslabnotebook.blogspot.fr/2011/06/drawing-heatmaps-in-r.html




