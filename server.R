

library(shiny)
library(ggplot2)
library(dplyr)
library(broom)





# Define server logic 

shinyServer(function(input, output, session) {
  
  df <- data.frame()
   
  output$Plot <- renderPlot({
    
    if (is.null(input$variable))
      return(NULL)
    
    ifelse(is.numeric(df[,as.character(input$variable)]),
           return(ggplot(aes_string(x = input$variable), data = df) +
                    geom_histogram(bins = input$bins) + theme_minimal() +
                    scale_x_continuous(limits = c(input$xmin, input$xmax))
                    ),
           return(ggplot(aes_string(x = input$variable), data = df) +
                    geom_bar() + theme_minimal()))
    
    
  })
  
  output$condPanel <- renderUI({
    if (is.null(input$variable))
      return(NULL)
    
    if (is.numeric(df[,as.character(input$variable)])){
      fluidRow(
        column(3,
               sliderInput(
        "bins",
        "Number of bins:",
        min = 1,
        max = 50,
        value = 30
      )),
      column(4, offset = 1, numericInput("xmin", label = "X min", value = NULL)),
      column(4, numericInput("xmax", label = "X max", value = NULL)))
    }
        })
                                              
  output$dataframe <- renderDataTable({
    inFile <- input$datafile
    
    if (is.null(inFile))
      return(NULL)
    
    df <<- read.csv(inFile$datapath)
    updateSelectizeInput(session, "variable",
                         choices = c("Write here" = "", names(df)), selected = names(df)[1])
    df
    
  }, options = list(scrollX = T, pageLength = 5))
  
  output$stat_summary <- renderDataTable({
    summary(df[,as.character(input$variable)]) %>% tidy
  }, options = list(dom = 't', searching = F))
})
