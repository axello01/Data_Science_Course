library(reshape2)

names(airquality) <- tolower(names(airquality))
head(airquality)

aql <- melt(airquality)

#Tomo month & day como IDs
aql2 <- melt(airquality, id.vars = c("month", "day"))
head(aql2)
