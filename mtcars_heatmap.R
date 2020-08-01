data(mtcars)
mtscaled <- as.matrix(scale(mtcars))
heatmap(mtscaled, Colv=F, scale='none')
