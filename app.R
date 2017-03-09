#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(rhandsontable)
library(Hmisc)
#devtools::install_github("dill/emoGG")

source('demo.R')

# Define UI for application that draws a histogram
ui <- dashboardPage(
  skin = "red",
  
  dashboardHeader(
    title = "R-Ladies Shiny Demo"
  ),
  dashboardSidebar(
    p("Shiny basics"),
    checkboxInput("manyChickens", "Check box to see all those chickens"),
    actionButton("goPlot", "Update Plot"),
    sliderInput("chicken", "Chickens", value = 0, min = 0, max = 10, step = 1),
    sliderInput("pig", "Pigs", value = 0, min = 0, max = 10, step = 1),
    sliderInput("cow", "Cows", value = 0, min = 0, max = 10, step = 1)
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

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  anTab <- eventReactive(input$goPlot, {
    animal.df <- data.frame(animal = Cs(Chickens, Pigs, Cows),
                            n  = c(input$chicken, input$pig, input$cow),
                            sym = c("1f414", "1f437", "1f42E"))
    
    # animal.df <- data.frame(animal = c("Dogs", "Cats", "Chickens"),
    #                         n  = c(input$dog, input$cat, input$chicken),
    #                         sym = c(emoji('dog'), emoji('cat'), emoji("chicken")))
    # 
    #animal.df <- animal.df[apply(animal.df, MARGIN = 1, function(x) x['n'] > 0),]
    
    return(animal.df)
  })
  
  output$animals <- renderPlot({
    if(input$goPlot == 0){
      data <- data.frame(x = runif(1), y = runif(1))
      ggblank(data)
    }else{
      anDat <- anTab()
      
      ind <- cumsum(anDat$n)
      
      nanimals <- sum(anDat$n)
      data <- data.frame(x = runif(nanimals), y = runif(nanimals))
      
      
      p <- ggblank(data)
      if(anDat[anDat$animal == 'Chickens','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[1:ind[1],], emoji='1f414') #chickens
      }
      if(anDat[anDat$animal == 'Pigs','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[(ind[1] + 1):ind[2],], emoji='1f437') #pigs
      }
      if(anDat[anDat$animal == 'Cows','n'] > 0){
        p <- p + emoGG::geom_emoji(data = data[(ind[2] + 1):ind[3],], emoji='1f42e') #cows
      }
      p
    }
  }, height = 500, width = 500)
}

# Run the application 
shinyApp(ui = ui, server = server)

