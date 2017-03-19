#Simple

library('shiny')
library('shinydashboard')
library('rhandsontable')


ui <- dashboardPage(
  skin = "yellow",
  
  dashboardHeader(
    titleWidth = 250,
    title = "R-Ladies Shiny Demo"
  ),
  dashboardSidebar(
    width = 250,
    tags$head(tags$style(HTML(".sidebar { width: 240px; margin-left: 5px; 
                              padding: 0px; margin-bottom: 0px; }"))),
    
    p("Choose some animals"),
    numericInput("chicken", "Chickens", value = 0, min = 0, step = 1),
    selectInput("bee", "Bees", choices = c(0, 10, 50, 100), selected = 0),
    radioButtons("pig", "Pigs", choices = c(0, 5, 10, 20), selected = 0),
    sliderInput("cow", "Cows", value = 0, min = 0, max = 10, step = 1),
    actionButton("goPlot", "Update Plot")
  ),
  dashboardBody(
    tags$head(tags$style(".wrapper {overflow: visible !important;}",
                         HTML(".sidebar { width: 240px; margin-left: 5px; 
                              padding: 5px; margin-bottom: 5px; }"))),
    checkboxInput("manyChickens", "Check box to see all those chickens"),
    em("(May be incompatible with some browsers.)"),
    conditionalPanel(
      condition = "input.manyChickens == true",
      tags$video(src = "allthosechickens.mp4", type = "video/mp4",
                 width = "350px", height = "350px", controls = "controls")
    ),
    rHandsontableOutput("notsure"),
    plotOutput("animals"),
    HTML("<div style='height: 100px;'>")
  )
)