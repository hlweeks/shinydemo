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
#library(emojifont)
#devtools::install_github("dill/emoGG")

# Define UI for application that draws a histogram
ui <- dashboardPage(

   dashboardHeader(
     title = "R-Ladies Shiny Demo"
   ),
   dashboardSidebar(
     p("This is a demonstration about how to use Shiny."),
     sliderInput("dog", "Dogs", value = 0, min = 0, max = 10, step = 1),
     sliderInput("cat", "Cats", value = 0, min = 0, max = 10, step = 1),
     sliderInput("chicken", "Chickens", value = 0, min = 0, max = 10, step = 1),
     actionButton("goPlot", "Update Plot")
   ),
   dashboardBody(
     rHandsontableOutput("notsure"),
     plotOutput("animals")
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  anTab <- eventReactive(input$goPlot, {
    animal.df <- data.frame(animal = c("Dogs", "Cats", "Chickens"),
                            n  = c(input$dog, input$cat, input$chicken),
                            sym = c("1f436", "1f431", "1f414"))

    # animal.df <- data.frame(animal = c("Dogs", "Cats", "Chickens"),
    #                         n  = c(input$dog, input$cat, input$chicken),
    #                         sym = c(emoji('dog'), emoji('cat'), emoji("chicken")))
    # 
    animal.df <- animal.df[apply(animal.df, MARGIN = 1, function(x) x['n'] > 0),]
    
    return(animal.df)
  })

  output$animals <- renderPlot({
    if(input$goPlot == 0){
      ggplot() + geom_blank() + xlim(-3, 3) + ylim(-3, 3)
    }else{
      # ggplot() + geom_emoji('dog', anDat$n[1]) + geom_emoji('cat', anDat$n[2]) + 
      #   theme_classic() + ylim(0, max(anDat$n)) + ggtitle("The Farm")
      
      # x = seq(0, 2*pi, length=30)
      # y = sin(x)
      # ggplot() + geom_emoji('heartbeat', x=x, y=y, size=10)
      
      ggplot(aes(rnorm(anDat$n[1]), rnorm(anDat$n[1]))) + geom_point() #emoGG::geom_emoji(emoji = '1f436
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

