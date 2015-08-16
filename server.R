library(shiny)
require(quantmod)
require(PerformanceAnalytics)
library(ggplot2); library(caret); library(xtable)

# Define server logic for random distribution application
shinyServer(function(input, output) {

  
  load.close.data <-function() {
    closedata <- NULL
    start_date <- input$dates[1]
    end_date <- input$dates[2]
    range <- paste(start_date, "::", end_date, sep = "")
    testStock <- input$tStock
    stockFile <- paste0("data/",testStock,".txt")
    if(!file.exists(stockFile)){
      sdata <- getSymbols(testStock, auto.assign=FALSE)
      sdata.df <- data.frame(date=time(sdata),coredata(sdata),row.names=1)
      write.table(sdata.df,stockFile)
      
    } else {
      sdata.df <- read.table(stockFile)
      sdata <- xts(sdata.df, order.by=as.Date(row.names(sdata.df)))
      
    }
    closedata <- sdata[,6]
    #    stocks <- read.table("stocks.txt", header=TRUE, sep=";")
    stocks <- input$stock
    for (i in 1 : length(stocks)) {
      stockid <- stocks[i]
      stockFile <- paste0("data/",stockid,".txt")
      if(!file.exists(stockFile)){
        
        sdata <- getSymbols(stockid, auto.assign=FALSE)
        sdata.df <- data.frame(date=time(sdata),coredata(sdata),row.names=1)
        write.table(sdata.df,stockFile)
        
      } else {
        sdata.df <- read.table(stockFile)
        sdata <- xts(sdata.df, order.by=as.Date(row.names(sdata.df)))
        
      }
      
      closedata <-  merge(closedata, sdata[,6])
      
    }
    colnames(closedata) <- c(testStock,stocks)
    closedata <- closedata[range]
    closedata <- closedata[complete.cases(closedata),]
    head(closedata)
    return(closedata)
  }
  
  
  output$DateRange <- renderText({
    # make sure end date later than start date
    validate(
      need(input$dates[2] > input$dates[1], "end date is earlier than start date"
      )
    )
    
    # make sure greater than 2 week difference
    validate(
      need(difftime(input$dates[2], input$dates[1], "days") > 14, "date range less the 14 days"
      )
    )
    
    paste("Your date range is", 
          difftime(input$dates[2], input$dates[1], units="days"),
          "days")
  })
  
  
 
  # Reactive expression to generate the requested distribution.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
 

 
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    closedata <- load.close.data()
    summary(closedata)
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    closedata <- load.close.data()
    head(closedata)
  })
  # Generate an HTML table view of the data
  output$stocks <- renderTable({
    read.table("indexes.txt", header=FALSE) 
  })
  # Generate an HTML table view of the data
  output$correlation <- renderPrint({
    closedata <- load.close.data()
    cor(closedata) 
  })
  output$absolute.plot <- renderPlot({
  closedata <- load.close.data()
 
 #  featurePlot(x=closedata[,2],,y=closedata[,3], plot="pairs") 
 y <- as.vector(closedata[,1])
 plotdata <- closedata[,-1]
 featurePlot(x=plotdata[,colnames(plotdata)],y=as.vector(closedata[,1]), plot=input$plt) 
  })

output$return.plot <- renderPlot({
  closedata <- load.close.data()
  for (i in 1 : ncol(closedata)) {
    closedata[,i] <- diff(closedata[,i])
  }
  #  featurePlot(x=closedata[,2],,y=closedata[,3], plot="pairs") 
  y <- as.vector(closedata[,1])
  plotdata <- closedata[,-1]
#  featurePlot(x=plotdata[,colnames(plotdata)],y=as.vector(plotdata[,0]), plot=input$plt) 
  featurePlot(x=plotdata[,colnames(plotdata)],y=as.vector(closedata[,1]), plot=input$plt) 
})
output$relative.trade <- renderPlot({
  
  closedata <- load.close.data()
  for (i in 1 : ncol(closedata)) {
    initialval <- as.vector(closedata[1,i])
    closedata[,i] <- closedata[,i]/initialval
  }
  head(closedata)
  zoo.closedata <- as.zoo(closedata)
  # Set a color scheme:
  tsRainbow <- rainbow(ncol(zoo.closedata))
  # Plot the overlayed series
  plot(x = zoo.closedata, ylab = "Cumulative Return", main = "Cumulative Returns",
       col = tsRainbow, screens = 1)
  # Set a legend in the upper left hand corner to match color to return series
  legend(x = "topleft", legend = colnames(closedata), 
         lty = 1,col = tsRainbow) 
})
output$relative.return <- renderPlot({
  closedata <- load.close.data()
  for (i in 1 : ncol(closedata)) {
    initialval <- as.vector(closedata[1,i])
    closedata[,i] <- closedata[,i]/initialval
  }
  for (i in 1 : ncol(closedata)) {
    closedata[,i] <- diff(closedata[,i])
  }
  zoo.closedata <- as.zoo(closedata)
  # Set a color scheme:
  tsRainbow <- rainbow(ncol(zoo.closedata))
  # Plot the overlayed series
  plot(x = zoo.closedata, ylab = "Cumulative Return", main = "Cumulative Returns",
       col = tsRainbow, screens = 1)
  # Set a legend in the upper left hand corner to match color to return series
  legend(x = "topleft", legend = colnames(closedata), 
         lty = 1,col = tsRainbow) 
  })
output$plot4 <- renderPlot({
   closedata <- load.close.data()
  for (i in 1 : ncol(closedata)) {
    initialval <- as.vector(closedata[1,i])
    closedata[,i] <- closedata[,i]/initialval
  } 
  
  for (i in 1 : ncol(closedata)) {
    closedata[,i] <- diff(closedata[,i])
  }

  #  featurePlot(x=closedata[,2],,y=closedata[,3], plot="pairs") 
  y <- as.vector(closedata[,1])
  plotdata <- closedata[,-1]
  #  featurePlot(x=plotdata[,colnames(plotdata)],y=as.vector(plotdata[,0]), plot=input$plt) 
  featurePlot(x=plotdata[,colnames(plotdata)],y=as.vector(closedata[,1]), plot=input$plt) 
  })
output$plot1 <- renderPlot({
  closedata <- load.close.data()
  for (i in 1 : ncol(closedata)) {
    initialval <- as.vector(closedata[1,i])
    closedata[,i] <- closedata[,i]/initialval
  }
  
  #  featurePlot(x=closedata[,2],,y=closedata[,3], plot="pairs") 
  # y <- as.vector(closedata[,1])
  #  plotdata <- closedata[,-1]
  as.vector(closedata[,1])
  plotdata <- as.data.frame(cbind(as.vector(closedata[,1]),as.vector(closedata[,2])))
  plot(plotdata$V1, plotdata$V2 )
  abline((lm(V1 ~ V2, plotdata)), lwd=2)
  })

})

