library(FNN)
library(MASS)


stocks <- read.csv('NFLX.csv')

RemoveDollarSign <- function(ticker){
  ticker$Close = as.numeric(gsub("[\\$,]", "", ticker$Close))
  ticker$Open = as.numeric(gsub("[\\$,]", "", ticker$Open))
  ticker$High = as.numeric(gsub("[\\$,]", "", ticker$High))
  ticker$Low = as.numeric(gsub("[\\$,]", "", ticker$Low))
  
    return (ticker)
}

stocks = RemoveDollarSign(stocks)

set.seed(42)
stocks_idx = sample(1:nrow(stocks), size = 250, replace = TRUE)
trn_stocks = stocks[stocks_idx, ]
tst_stocks  = stocks[-stocks_idx, ]

X_trn_stocks = trn_stocks["Compound"]
X_tst_stocks = tst_stocks["Compound"]
y_trn_stocks = trn_stocks["Close"]
y_tst_stocks = tst_stocks["Close"]

X_trn_stocks_min = min(X_trn_stocks)
X_trn_stocks_max = max(X_trn_stocks)
lstat_grid = data.frame(lstat = seq(X_trn_stocks_min, X_trn_stocks_max, 
                                    by = 0.01))

pred_001 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 1)
pred_005 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 5)
pred_010 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 10)
pred_050 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 50)
pred_100 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 100)
pred_250 = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = 250)

df <- cbind(pred_001$pred)
df2 = stocks$Close[0:146]
df = df[0:146]

plot(df2, pch=0, col="red",type="l",lwd=1,xlab="Days", ylab="Prices")
lines(df, pch=0,col="blue")
title("AMZN k = 250")
legend(c("Actual","Predicted"), lwd=c(5,2), col=c("red","blue"), y.intersp=0.6,x="top" )

k <- c(1,5,50,100,250)
for(x in k){
  predic = knn.reg(train = X_trn_stocks, test = lstat_grid, y = y_trn_stocks, k = x)
  d = predic$pred
  accuracy[x] <- mean( d[0:100]== df2[0:100])
}

plot(k, accuracy[0:5], type = 'b',xlab="k values",ylab="Accuracy")




