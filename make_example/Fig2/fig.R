library(ggplot2)
library(GGally)

png("fig.png",width=1000,height=1000)
ggpairs(mtcars[,1:5])
dev.off()