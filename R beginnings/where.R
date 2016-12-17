setwd('C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/R beginnings')

met <- read.csv("landings.csv", head = TRUE, sep = ",")

latitude <- met$reclat
longitude <-met$reclong

plot(longitude, latitude, main = "Plots of Latitude vs. Longitude")
#This is actually really cool, it's recognizably a map of the world!

#Radius <- 1 # for convenience of scaling
#z <- lapply(latitude, function(p) Radius*sin(p*pi/180))

#Histograms
#hist(latitude, density=75, col = "green", border = "black", main = "Histogram of Latitudes")
#hist(longitude, density=75, col = "blue", border = "black", main = "Histogram of Longitudes")

plot(density(latitude,na.rm=TRUE), col = "green", main = "Density of Latitude and Longitude",lwd=2)
lines(density(longitude,na.rm=TRUE), col="blue",lwd=2)

legend(0,0.025, c("Longitude","Latitude"),lwd=c(2,2),col=c("blue","green"))

library(RColorBrewer)
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(32)
df <- data.frame(longitude,latitude)

plot(df, pch=16, col='black', cex=0.5)

library(hexbin)
h <- hexbin(df)
#plot(h)

hexbinplot(latitude~longitude, data=df, colramp=rf, mincnt=1,maxcnt=500,
           main = "Hexagonal Data bining of Meteorite Landings")

library(ggplot2)
ggplot(met, aes(x=reclong, y=reclat, color=mass..g.)) + geom_point()
library(dplyr)
HeavyMet <- met %>% filter(mass..g. >= 1000)
ggplot(HeavyMet, aes(x=reclong, y=reclat, color=mass..g.)) + geom_point()
LightMet <- met %>% filter(mass..g. <= 1000)
ggplot(LightMet, aes(x=reclong, y=reclat, color=mass..g.)) + geom_point()

hist(met$mass..g., plot = TRUE)
# based on the above histogram, exclude the excessively heavy meteorites (greater than 1e+07)

LightMet <- met %>%filter(mass..g. <= 10^6)
ggplot(LightMet, aes(x=reclong, y=reclat, color=mass..g.)) + geom_point()
hist(LightMet$mass..g., plot = TRUE)

MiddleMet <- met %>% filter(mass..g. >=7 ) %>% filter(mass..g. <= 13280)
p <- ggplot(MiddleMet, aes(x=reclong, y=reclat, color=mass..g.)) + geom_point()
p <- p + aes(shape = recclass)
p
