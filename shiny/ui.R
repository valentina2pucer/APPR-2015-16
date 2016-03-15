library(shiny)


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
                    
                    mainPanel(plotOutput("zem"))
                  )
))

