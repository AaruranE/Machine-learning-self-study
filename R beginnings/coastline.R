
library(rgdal)
setwd("C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/R beginnings")

coast <-readOGR(dsn = "ne_10m_coastline", layer = "ne_10m_coastline")
plot(coast)
