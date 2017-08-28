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
  tabsetPanel(
  tabPanel(
    "Dataset", list(fileInput("datafile", "Data"), dataTableOutput("dataframe"))
    ),
  tabPanel(
    "Variable",
    list(
      selectizeInput("variable", "Choose one variable", choices = c("Choose one" = "")),
      uiOutput("condPanel"),
      plotOutput("distPlot"),
      dataTableOutput("stat_summary")
    )
  ))
))

