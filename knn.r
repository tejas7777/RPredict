library(class)
library(dplyr)
library(lubridate)
library(ggplot2)
set.seed(100)


stocks <- read.csv('stocks.csv')

stocks$Date <- ymd(stocks$Date)
stocksTrain <- year(stocks$Date) < 2014
print(stocksTrain)

predictors <- cbind(lag(stocks$Apple, default = 210.73), lag(stocks$Google, default = 619.98), lag(stocks$MSFT, default = 30.48))

prediction <- knn(predictors[stocksTrain, ], predictors[!stocksTrain, ], stocks$Increase[stocksTrain], k = 1)
  
table(prediction, stocks$Increase[!stocksTrain])

mean(prediction == stocks$Increase[!stocksTrain])


accuracy <- rep(0, 10)
k <- 1:10
for(x in k){
  prediction <- knn(predictors[stocksTrain, ], predictors[!stocksTrain, ],
                    stocks$Increase[stocksTrain], k = x)
  accuracy[x] <- mean(prediction == stocks$Increase[!stocksTrain])
}
plot(k, accuracy, type = 'b')
title("KNN Classifier Accuracy")



