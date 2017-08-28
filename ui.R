library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Discover your data"),
  
  # Sidebar with a slider input for number of bins
  tabsetPanel(
  tabPanel(
    ## TODO: Add header, sep and file format input
    "Dataset", list(fileInput("datafile", "Data"), dataTableOutput("dataframe"))
    ),
  tabPanel(
    "Variable",
    list(
      selectizeInput("variable", "Choose one variable", choices = c("Choose one" = "")),
      uiOutput("condPanel"),
      plotOutput("Plot"),
      dataTableOutput("stat_summary")
    )
  ))
))

