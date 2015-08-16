library(shiny)
stocks <- read.table("indexes.txt", header=FALSE) 
colnames(stocks) <- c("Stock","Desc")

# Define UI for random distribution application 
shinyUI(fluidPage(
    
  # Application title
  titlePanel("Stock Correlation Plotting"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    
    sidebarPanel(
    
      
    radioButtons("plt", "Choose a Plot type:",
                   c("Scatter" = "scatter",
                     "Pairs" = "pairs"
                     )),
      br(),
  
      selectInput("tStock", "Choose a Test Stock:",
                  as.character(stocks$Stock),
                  selected = as.character(stocks$Stock[1]),
                  multiple = FALSE
                  ),
      br(),
      
      selectInput("stock", "Choose Stocks:",              
                  as.character(stocks$Stock),,
                  selected = as.character(stocks$Stock)[2],
                  multiple = TRUE
      ),
      br(),
 
      dateRangeInput("dates", 
                   "Select a Date range",
                   start = "2014-01-01", 
                   end = as.character(Sys.Date()))
      ),

    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("AbsolutePlot", plotOutput("absolute.plot")),
        tabPanel("ReturnPlot", plotOutput("return.plot")), 
        tabPanel("RelativeTrad", plotOutput("relative.trade")),
        tabPanel("RelativeReturn", plotOutput("relative.return")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table")),
        tabPanel("Correlation", verbatimTextOutput("correlation")),
        tabPanel("Stocks", tableOutput("stocks"))
      )
    )
  )
))
