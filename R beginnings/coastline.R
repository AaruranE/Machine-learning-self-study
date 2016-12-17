
library(rgdal)
setwd("C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/R beginnings")

coast <-readOGR(dsn = "ne_10m_coastline", layer = "ne_10m_coastline")
plot(coast)
abline(v=0)
abline(h=0)
ggplot(HeavyMet, aes(x=reclong, y=reclat)) + geom_point() + plot(coast)


