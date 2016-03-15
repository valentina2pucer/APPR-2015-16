library(shiny)
runApp("shiny")

library(maps)
library(mapproj)
source("helpers.R")

#Aplikacija bo delovala tako, da boš lahko pogledal gostoto smrtnih žrtev na posameznih 
#območjih
#priprava ustrezne tabele:
zem_tabela<-nesrece %>% select(Lokacija,Smrtne.žrtve)

attach(zem_tabela)
oznaka1<-c("Redko","Manj gosto","Gosto","Najgosteje")
stopnja1<-character(nrow(zem_tabela))
stopnja1[Smrtne.žrtve<=100]<-"Redko"
stopnja1[Smrtne.žrtve>100 & Smrtne.žrtve<300]<-"Manj gosto"
stopnja1[Smrtne.žrtve>=300 & Smrtne.žrtve<1000]<-"Gosto"
stopnja1[Smrtne.žrtve>=1000]<-"Najgosteje"
Razvrstitev<-factor(stopnja1,levels=oznaka1, ordered=TRUE)
detach(zem_tabela)

zem_tabela<-data.frame(zem_tabela,Razvrstitev)

shinyUI(fluidPage(titlePanel("Gostota smrtnih žrtev"),
  
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


shinyServer(
  function(input, output){ 
  output$zem<-renderPlot({
    data<-switch(input$var,
                 "Redko" = zem_tabela$? kaj moram tukaj,
                 "Manj gosto" = zem_tabela$Smrtne.žrtve,
                 "Gosto" = zem_tabela$Smrtne.žrtve,
                 "Najgosteje" =zem_tabela$Smrtne.žrtve ))
  
          color <- switch(input$var, 
            "Redko" = "darkgreen",
            "Manj gosto" = "black",
            "Gosto" = "darkorange",
            "Najgosteje" = "darkviolet"))
    
    percent_map(var = data,  #ali je tukaj kaka funkcijaza moj primer
                color = color, 
                legend.title = legend, 
                max = input$range[2], 
                min = input$range[1])
    
  })
  }
)
