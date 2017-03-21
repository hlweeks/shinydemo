library('shiny')
library('shinydashboard')
library('rhandsontable')

source('demo.R')

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
           # Prevent error that very briefly appears
           tags$style(type="text/css",
                      ".shiny-output-error { visibility: hidden; }",
                      ".shiny-output-error:before { visibility: hidden; }"),
           
           sidebarLayout(
             sidebarPanel(
               selectInput("data", "Choose a data set", choices = dat_names, selected = "trees"),
               textOutput("data_info")
             ),
             mainPanel(
               uiOutput("variables"),
               plotOutput("plot")
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
                        rHandsontableOutput("rhot2")
                 )
               )
             )
           )

  )
)
)
