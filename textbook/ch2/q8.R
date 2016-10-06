library(ISLR)
data(College)

//summary()
pairs(College[,1:10])
boxplot(College$Outstate ~ College[,1])  

Elite = rep("No", nrow(College))
Elite[College$Top10perc>50]="Yes"
Elite=as.factor(Elite)
College = data.frame(College, Elite)


boxplot(College$Outstate ~ College$Elite, main="Outstate vs. Elite")

