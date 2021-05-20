
#library(pryr)
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
# 
# df <- read_csv("NFLX.csv")
# df = RemoveDollarSign(df)
# 
# df2 <- data.frame(df$Close,df$Compound)
# 
# #initialize plot
# plot(df2, pch=16)
# 
# #initlialize model
# model <- svm(Compound ~ Close , data = df, ranges=list(elsilon=seq(0,1,0.1), cost=1:100))
# 
# # make a prediction for each X
# predictedY <- predict(model, df)
# 
# #print(predictedY)
# 
# # display the predictions
# points(df$Close, predictedY, col = "blue", pch=4)
# 
# 



# stocks <- c("NFLX", "MSFT", "TSLA","AMZN","GOOG")
# #gen_env <- where("stocks")
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#   
#   # Application title
#   titlePanel("Stockify"),
#   
#   # Sidebar with a slider input for number of bins
#   sidebarLayout(
#     sidebarPanel(
#       selectInput("Stocks", "Select the stocks", choices = stocks)
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("StockOutput")
#     )
#   )
# )
# 
# 
# server <- function(input,output){
#   output$StockOutput <- renderPlot({
#     # use the 'genders' vector on the server side as well
#     #input$Stocks
#     newPredict(which(stocks %in% input$Stocks))
#   })
#   
# }

predictStock <- function(a){
  print(a)
  val <- switch(
    a,
    "NFLX.csv",
    "MSFT.csv",
    "TSLA.csv",
    "AMZN.csv",
    "GOOG.csv",
  )
  df <- read_csv(paste(val))
  df = RemoveDollarSign(df)
  
  df2 <- data.frame(x = df$Close,y = df$Compound)
  
  #initialize plot    
  y<-plot(df2, pch=16)
  
  #initlialize model
  model <- svm(y ~ x , data = df2, ranges=list(elsilon=seq(0,1,0.1), cost=1:100))
  
  xtest = data.frame(x=c(7, 2, 3))
  
  
  
  # make a prediction for each X
  predictedY <- predict(model, df2)
  
  #print(predictedY)
  
  # display the predictions
  points(df$Close, predictedY, col = "blue", pch=4)
  
  return (y)
  
  
}

newPredict <- function(a){
  print(a)
  val <- switch(
    a,
    "NFLX.csv",
    "MSFT.csv",
    "TSLA.csv",
    "AMZN.csv",
    "GOOG.csv",
  )
  df <- read_csv(paste(val))
  df = RemoveDollarSign(df)
  
  library(FNN)   #knn regression
  set.seed(1974) #fix the random generator seed 
  
  df2 <- data.frame(x = df$Close,y = df$Compound)
  
  #Fit a knn regression with k=3
  #using the knn.reg() function from the FNN package
  knn3.bmd <- knn.reg(train=df2$x,   
                      y=df2$y, 
                      test= data.frame(x=seq(0,1)),
                      k=3)    
}

predictStock(1)
# Run the application 
# shinyApp(ui = ui, server = server)