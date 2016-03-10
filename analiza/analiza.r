# 4. faza: Analiza podatkov
library(ggplot2)

nesrece$Row <- 1:nrow(nesrece)
tabela_1 <- lapply(tabelaBDP$State, function(x) {
  r <- grep(x, nesrece$Lokacija)
  return(data.frame(State = rep(x, length(r)), Row = r))
}) %>% bind_rows() %>% as.data.frame() %>%
  inner_join(nesrece, by = "Row") %>%
  inner_join(tabelaBDP, by = "State") %>%
  select(Lokacija = State, Škoda,Smrtne.žrtve, PovprecjeBDP)



ggplot(tabela_1, aes(x = Lokacija, y = PovprecjeBDP/1000)) +
  geom_bar(stat = "identity") + xlab("Lokacija") +
  ggtitle("Ali je povezava med stopnjo škode in smrti s povprečnim BDP lokacije?") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))+ 
  
  plot(tabela_1$Škoda)+
  lines(tabela_1$Škoda,col="red")+
    
  plot(tabela_1,aes(y=tabela_1$Smrtne.žrtve))+
    lines(tabela_1$Smrtne.žrtve,col="green")




     