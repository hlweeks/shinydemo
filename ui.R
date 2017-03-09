library('shiny')
library('shinydashboard')
library('rhandsontable')


ui <- dashboardPage(
  skin = "red",
  
  dashboardHeader(
    title = "R-Ladies Shiny Demo"
  ),
  dashboardSidebar(
    p("Shiny basics"),
    checkboxInput("manyChickens", "Check box to see all those chickens"),
    em("(May be incompatible with some browsers.)"),
    HTML('<br/><br/><br/>'),
    p("What animals would you like to have on the farm?"),
    sliderInput("chicken", "Chickens", value = 0, min = 0, max = 10, step = 1),
    sliderInput("pig", "Pigs", value = 0, min = 0, max = 10, step = 1),
    sliderInput("cow", "Cows", value = 0, min = 0, max = 10, step = 1),
    actionButton("goPlot", "Update Plot")
  ),
  dashboardBody(
    conditionalPanel(
      condition = "input.manyChickens == true",
      tags$video(src = "allthosechickens.mp4", type = "video/mp4",
                 width = "350px", height = "350px", controls = "controls")
    ),
    rHandsontableOutput("notsure"),
    plotOutput("animals")
  )
)
