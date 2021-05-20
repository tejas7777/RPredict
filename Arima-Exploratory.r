

ARIMA <- function(ticker){
  indf_data <- getSymbols(Symbols = ticker, src = "yahoo", from = Sys.Date() - 1953, 
                          to = Sys.Date(), auto.assign = FALSE)
  
  indf_data <- Cl(indf_data)
  
  library(caTools)
  train_data <- indf_data[1:1270]
  
  library(forecast)
  set.seed(123)
  arima_model <- auto.arima(train_data, stationary = TRUE, ic = c("aicc", "aic", "bic"), 
                            trace = TRUE)
  
  summary(arima_model) ###summary for choosen best arima(p,d,q) model
  
  checkresiduals(arima_model) ###diagnostic cheking
  
  arima <- arima(train_data, order = c(1, 1, 0))
  summary(arima)
  
  forecast1 <- forecast(arima, h = 100)
  plot(forecast1)
  
}
