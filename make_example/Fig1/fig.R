x = runif(100)
y = 3+5*x + rnorm(100,sd=0.3)

png("fig.png")
plot(x,y, main="My Figure")
abline(lm(y~x))
dev.off()