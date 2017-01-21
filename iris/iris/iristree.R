library(party)

if(FALSE){
  getwd()
  
}
setwd("C:/Users/Aaruran/Documents/GitHub/Machine learning Self-study/iris/iris/")


iris <- read.csv("iris.csv")
attach(iris)
png(file = "iris_tree.png")
output.tree <- ctree(Species ~ SepalLengthCm + SepalWidthCm + PetalLengthCm + PetalWidthCm, data=iris)
plot(output.tree)
