#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(broom)





# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  df <- data.frame()
   
  output$distPlot <- renderPlot({
    
    if (is.null(input$variable))
      return(NULL)
    
    ifelse(is.numeric(df[,as.character(input$variable)]),
           return(ggplot(aes_string(x = input$variable), data = df) +
                    geom_histogram(bins = input$bins) + theme_minimal()),
           return(ggplot(aes_string(x = input$variable), data = df) +
                    geom_bar() + theme_minimal()))
    
    
  })
  
  output$condPanel <- renderUI({
    if (is.null(input$variable))
      return(NULL)
    
    if (is.numeric(df[,as.character(input$variable)]))
      sliderInput(
        "bins",
        "Number of bins:",
        min = 1,
        max = 50,
        value = 30
      )
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
