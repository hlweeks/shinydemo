library('shiny')
library('shinydashboard')
library('ggplot2')
library('rhandsontable')

#################################
#Define helper functions outside the shiny `ui` and `server` objects
#Alternative: source('demo.R')

#Function to produce blank ggplot window
ggblank <- function(data){
  ggplot(data, aes(x, y)) + 
    geom_rect(aes(xmax = 1.1, xmin = -0.1, ymax = 1.1, ymin = -0.1, fill = 'none'), 
              color = 'black', alpha = 0) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          #panel.background = element_rect(fill = "grey50"),
          panel.background = element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.x=element_blank(),
          axis.ticks.y=element_blank(),
          plot.title = element_text(hjust = 0.5),
          legend.position = 'none') +
    xlab("") + ylab("") + ggtitle("")
}
#################################

shinyServer(function(input, output) {
  
  anTab <- eventReactive(input$goPlot, {
    animal.df <- data.frame(animal = c("Chickens", "Pigs", "Cows"),
                            n  = c(input$chicken, input$pig, input$cow),
                            sym = c("1f414", "1f437", "1f42E"))
    
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
})