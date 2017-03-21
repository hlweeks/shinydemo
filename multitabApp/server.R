library('shiny')
library('shinydashboard')
library('rhandsontable')


shinyServer(function(input, output) {
  
  output$data_info <- renderText({
    dat_titles[which(input$data == dat_names)]
  })
  
  output$variables <- renderUI({
    data(list = input$data)
    
    fluidRow(
      column(4,
             selectInput("xvar", "Variable 1", choices = colnames(get(input$data)))
             ), 
      column(4,
             selectInput("yvar", "Variable 2", choices = colnames(get(input$data)))
             )
      )
  })
  
  output$plot <- renderPlot({
    data(list = input$data)
    
    with(get(input$data), plot(get(input$xvar), get(input$yvar), 
                               xlab = input$xvar, ylab = input$yvar))
  })
  
})