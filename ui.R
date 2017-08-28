#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Discover your data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectizeInput("variable","Choose one variable", choices = c("Choose one" = "")),
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Dataset", list(fileInput("datafile", "Data"),dataTableOutput("dataframe"))),
        tabPanel("Variable",list(plotOutput("distPlot"),  dataTableOutput("stat_summary")))
      )
    )
  )
))
