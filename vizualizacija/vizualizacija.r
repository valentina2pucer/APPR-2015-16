# 3. faza: Izdelava zemljevida
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(dplyr)

# Uvozimo zemljevid.
zda <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/states_21basic.zip", "states")
capitals <- read.csv("podatki/uscapitals.csv")
row.names(capitals) <- capitals$state
capitals <- preuredi(capitals, zda, "STATE_NAME")
capitals$US.capital <- capitals$capital == "Washington"

tabela1$Row <- 1:nrow(tabela1)
drzave.nesrece <- lapply(zda$STATE_NAME, function(x) {
  r <- grep(x, tabela1$Location)
  return(data.frame(State = rep(x, length(r)), Row = r))
}) %>% bind_rows() %>% as.data.frame()
zdruzena.tabela <- inner_join(tabela1, drzave.nesrece, by = "Row")

pretvori.zemljevid <- function(zemljevid) {
  fo <- fortify(zemljevid)
  data <- zemljevid@data
  data$id <- as.character(0:(nrow(data)-1))
  return(inner_join(fo, data, by="id"))

zem <- pretvori.zemljevid(zda)
ggplot() + geom_polygon(data = zdruzena.tabela %>% group_by(State) %>%
                          summarise(Fatalities = sum(Fatalities)) %>%
                          right_join(zem, by = c("State" = "STATE_NAME")),
                        aes(x = long, y = lat, group = group, fill = Fatalities))
print(zem)


