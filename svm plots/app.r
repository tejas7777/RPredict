library(readr)

#Load Library
library(e1071)
  
RemoveDollarSign <- function(ticker){
  ticker$Close = as.numeric(gsub("[\\$,]", "", ticker$Close))
  ticker$Open = as.numeric(gsub("[\\$,]", "", ticker$Open))
  ticker$High = as.numeric(gsub("[\\$,]", "", ticker$High))
  ticker$Low = as.numeric(gsub("[\\$,]", "", ticker$Low))
  
  return (ticker)
}

df <- read_csv("AMZN.csv")
df = RemoveDollarSign(df)

df2 <- data.frame(df$Close,df$Compound)

#initialize plot
plot(df2, pch=1,col="red",xlab="Stock prices",ylab="Sentiments")

#initlialize model
model <- svm(Compound ~ Close , data = df, ranges=list(elsilon=seq(0,1,0.1), cost=1:100))

# make a prediction for each X
predictedY <- predict(model, df)

#print(predictedY)

# display the predictions

points(df$Close, predictedY, col = "blue", pch=4)
title("AMZN")
legend(c("Actual","Predicted"), lwd=c(2,2), col=c("red","blue"), y.intersp=0.6,x.intersp=0.75,x="bottomleft" )
