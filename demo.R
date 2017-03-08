#Function to produce blank ggplot window

ggblank <- function(data, x, y){
  ggplot(data, aes(x, y)) + 
    geom_rect(aes(xmax = 1.1, xmin = -0.1, ymax = 1.1, ymin = -0.1, fill = 'none'), 
              color = 'black', alpha = 0) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.x=element_blank(),
          axis.ticks.y=element_blank(),
          legend.position = 'none') +
    xlab("") + ylab("")
}

data <- data.frame(x = runif(30), y = runif(30))
ggblank(data, x, y) + 
  emoGG::geom_emoji(data = data[1:10,], emoji='1f436') + 
  emoGG::geom_emoji(data = data[11:20,], emoji='1f431') + 
  emoGG::geom_emoji(data = data[21:30,], emoji='1f414') 



  
