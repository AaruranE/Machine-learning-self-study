xMax <- 100
xMin <- 0
N <- 100

errorWidth <- 5

x <- runif(N, xMin, xMax)
error <- rnorm(N)*errorWidth
y <- 3*x + error

dummy <- data.frame(x=x, y = y)

plot(x,y, main = "Randomly generated numbers about the line y = 3*x")
fm <- lm(y~x, data = dummy)
summary(fm)

abline(fm)
