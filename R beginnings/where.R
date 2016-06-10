setwd('C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/R beginnings')

met <- read.csv("landings.csv", head = TRUE, sep = ",")

latitude <- met$reclat
longitude <-met$reclong

plot(longitude, latitude, "Plots of Latitude vs. Longitude")
#This is actually really cool, it's recognizably a map of the world!
