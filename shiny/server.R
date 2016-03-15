#library(shiny)

#Aplikacija bo delovala tako, da boš lahko pogledal gostoto smrtnih žrtev na posameznih 
#območjih
#priprava ustrezne tabele:
zem_tabela<-tabela_1 %>% select(Lokacija,Smrtne.žrtve)

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

shinyServer(
  function(input, output){ 
    output$zem<-renderPlot({
      ggplot() + geom_polygon(data = zem_tabela %>%
                                group_by(Lokacija, Razvrstitev) %>%
                                filter(Razvrstitev == input$var) %>%
                                right_join(zem, by = c("Lokacija" = "STATE_NAME")),
                              aes(x = long, y = lat, group = group,
                                  fill = Razvrstitev)) +
        scale_fill_manual(values = c("Redko" = "darkgreen",
                                     "Manj gosto" = "black",
                                     "Gosto" = "darkorange",
                                     "Najgosteje" = "darkviolet"),
                          na.value = "darkgrey")


    })
  }
)
