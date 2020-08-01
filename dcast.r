library(reshape2)
z <- data.frame(
                item=letters[rep(24:26,2)],
                freq=c(4,3,2,4,4,1),
                id=rep(1:2,each=3)
               )
			   

dcast(z, id ~ item, value.var="freq")

