library(class)

data.cancer <- read.csv("/home/i314/Desktop/DIPLO/Clase_15_Septiembre/cancer.data",header=F,sep=",")
data.cancer <- data.cancer[,-1]

norm.func <- function(x){ ((x - min(x)) / (max(x)))}

data.cancer.norm <- as.data.frame(lapply(data.cancer[,-1], norm.func))

data.cancer.train <- data.cancer.norm[1:450,]
data.cancer.test  <- data.cancer.norm[451:nrow(data.cancer.norm),]
data.cancer.label <- data.cancer[1:450,1] 

data.cancer.predict <- knn(data.cancer.train, data.cancer.test, data.cancer.label, k=21)

table(data.cancer.predict, data.cancer[451:nrow(data.cancer),1])
