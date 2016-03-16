# 4. faza: Analiza podatkov
library(ggplot2)

nesrece$Row <- 1:nrow(nesrece)
tabela_1 <- lapply(tabelaBDP$State, function(x) {
  r <- grep(x, nesrece$Lokacija)
  return(data.frame(State = rep(x, length(r)), Row = r))
}) %>% bind_rows() %>% as.data.frame() %>%
  inner_join(nesrece, by = "Row") %>%
  inner_join(tabelaBDP, by = "State") %>%
  select(-Lokacija) %>% rename(Lokacija = State)



ggplot(tabela_1, aes(x = Lokacija, y = PovprecjeBDP/1000)) +
  # position = "dodge": stolpci za isto državo so en zraven drugega (da ne bodo prikazani BDP-ji večji v državah z več nesrečami)
  geom_bar(stat = "identity", position = "dodge") +
  # position = "jitter": naključno zamaknemo pike, da bodo podobne vrednosti bolje vidne
  geom_point(aes(y = Škoda/1e9), position = "jitter") +
  ggtitle("Ali je povezava med stopnjo škode in smrti s povprečnim BDP lokacije?") +
  xlab("Lokacija") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))+
 geom_smooth(method = "lm")

ggplot(tabela_1, aes(x = PovprecjeBDP/1000, y = Škoda/1e9)) + geom_point()+geom_smooth(method = "lm")

ggplot(tabela_1, aes(x = PovprecjeBDP/1000, y = Smrtne.žrtve)) + geom_point()+geom_smooth(method = "lm")



#GRUČENJE:
tabela_3<-tabela_1 %>% filter(Tip.naravne.nesreče=="Flood")


ggplot(tabela_3, aes(x = Lokacija, y = PovprecjeBDP/1000)) +
  
  geom_bar(stat = "identity", position = "dodge") +
  geom_point(aes(y = Smrtne.žrtve), position = "jitter") +
  xlab("Lokacija") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))


tabela_4<-tabela_1 %>% filter(Tip.naravne.nesreče=="Tornado")

ggplot(tabela_4, aes(x = Lokacija, y = PovprecjeBDP/1000)) +
  
  geom_bar(stat = "identity", position = "dodge") +
  geom_point(aes(y = Škoda/1e8), position = "jitter") +
  xlab("Lokacija") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
     