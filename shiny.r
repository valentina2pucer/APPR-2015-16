library(shiny)
runApp("shiny")

library(maps)
library(mapproj)

if ("server.R" %in% dir()){setwd("..")}

shinyServer(
  function(input, output){ 
  output$zem<-renderPlot({
    data<-switch(input$var,
          color <- switch(input$var, 
            "Redko" = "darkgreen",
            "Manj gosto" = "black",
            "Gosto" = "darkorange",
            "Najgosteje" = "darkviolet"))
    
    percent_map(var = data, 
                color = color, 
                legend.title = legend, 
                max = input$range[2], 
                min = input$range[1])
    
  })
  }
)
shinyUI(fluidPage(
  titlePanel("Gostota smrtnih žrtev"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Poglej si gostoto smrtnih žrtev v naravnih nesrečah v ZDA."),
      
      selectInput("var", 
                  label = "Izberi gostoto, ki te zanima",
                  choices = c("Redko", "Manj gosto",
                              "Gosto", "Najgosteje"),
                  selected = "Redko")
      
     
      ),
    
    mainPanel(plotOutput("map"))
  )
))
