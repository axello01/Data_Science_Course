shop <- read.csv("/home/i314/Desktop/DIPLO/2016/Modulo_5/Clase_2/Dendogram/shopping.csv", header=T, sep=",")
shop_1 <- shop[,-1]
shop_2 <- scale(shop_1)

distancias <- dist(as.matrix(shop_2))

dendograma <- hclust(distancias)
plot(dendograma)

#V1: Shopping is fun (scale 1-7)
#V2: Shopping is bad for your budget (scale 1-7)
#V3: I combine shopping with eating out (scale 1-7)
#V4: I try to get the best buys while shopping (scale 1-7)
#V5: I don't care about shopping (scale 1-7)
#V6: You can save lot of money by comparingprices (scale 1-7)
#Income: the household income of the respondent (in dollars)
#Mall.Visits: how often they visit the mall (scale 1-7)

#Discutir las diferencias entre segmentar y perfilar
#Que variables utilizar para segmentar y cuales para perfilar

#http://inseaddataanalytics.github.io/INSEADAnalytics/Report_s45.html