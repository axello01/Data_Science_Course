frm(list=ls())

library(arules)

tr <- read.transactions("/home/i314/Desktop/titanic2.txt", format = "basket", sep=',', rm.duplicates=TRUE)
rules <- apriori(tr, parameter = list(supp = 0.002, conf = 0.8))
inspect(rules)

rules<-sort(rules, by="confidence", decreasing=TRUE)
inspect(rules)
