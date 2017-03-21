library('shiny')
library('shinydashboard')
library('rhandsontable')


shinyUI(navbarPage("R-Ladies Shiny Demo", id = "mainPage",
  # CSS file from 'www' folder that contains details for formatting, layout                 
  theme = "bootstrap.css",
  
  # Makes title area a little smaller than the default
  tags$head(tags$style('nav .container:first-child {
                        margin-left:10px; width: 100%;
                        }')),
  # Name of the tab that is selected by default
  selected = "Tab1",
  tabPanel("Tab1",
           sidebarLayout(
             sidebarPanel(
               #selectInput("variable names")
             ),
             mainPanel(
               plotOutput("plotly")
             )  
           )
  ),
  tabPanel("Tab2",
           sidebarLayout(
             sidebarPanel(
          
             ),
             mainPanel(
               fluidRow(
                 column(width = 6,
                        h4("Table title"),
                        rHandsontableOutput("rhot1")
                        ),
                 column(width = 6,
                        h4("Table title"),
                        rHandsontableOutput("rhot1")
                 )
               )
             )
           )

  )
)
)

library(mvtnorm)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      numericInput("n_obs", "Number of Observations", min = 0, value = 10),
      sliderInput("corr", "Correlation", min = -1, max = 1, step = .1, value = 0)),
    
    mainPanel(plotOutput("plot"))
))

server <- function(input, output){
  
  output$plot <- renderPlot({
    covMat <- diag(2) + matrix(c(0,1,1,0), nrow = 2)*input$corr
    data <- rmvnorm(input$n_obs, sigma = covMat)
    
    plot(data[,1], data[,2], xlab = "x", ylab = "y", main = "")
  })  
  
}

shinyApp(ui, server)
