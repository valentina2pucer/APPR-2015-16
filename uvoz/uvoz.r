# 2. faza: Uvoz podatkov,čiščenje...
library(knitr)
require(dplyr)
require(rvest)
require(gsubfn)
library(ggplot2)
library(plotrix)

#uvoz1
uvozi.nesrece<-function(){
  return(read.csv2("podatki/podatki anpr.csv", sep=";",
                    fileEncoding = "UTF-8", header = FALSE,
                    na.strings = c("Unknown"), as.is = TRUE,
                   col.names=c("Leto","Tip.naravne.nesreče","Smrtne.žrtve","Škoda","Dogodek","Lokacija","V7")
                   ))
}

cat("Uvažam podatke o naravnih nesrečah v ZDA...\n")
nesrece<-uvozi.nesrece()
nesrece$leto <- rep(NA, nrow(nesrece))
nesrece[60,-4] <- nesrece[58,-4]
prazne <- which(nesrece[,1] == "")
nesrece[prazne-1, "leto"] <- as.numeric(gsub("-", "", nesrece[prazne, 4]))
nesrece <- nesrece[-prazne,]
nesrece<-subset(nesrece, select=-V7)

nesrece <- nesrece[c("Leto","Lokacija","Tip.naravne.nesreče","Dogodek","Smrtne.žrtve","Škoda")]
nesrece$Lokacija <- gsub("\\?", " ", nesrece$Lokacija)
nesrece$Tip.naravne.nesreče <- gsub("\\?", " ", nesrece$Tip.naravne.nesreče)
nesrece$Dogodek <- gsub("\\?", "-", nesrece$Dogodek)
nesrece$Smrtne.žrtve <- gsub("\\?", "-", nesrece$Smrtne.žrtve)


#filtracija
attach(nesrece)
oznaka<-c("Večja","Manjša")

nesrece$Škoda <- gsub("\\$", "", nesrece$Škoda)
nesrece$Škoda <- gsub(",", "", nesrece$Škoda)
nesrece$Škoda <- gsub("^Billions$", "1000000000", nesrece$Škoda)
nesrece$Škoda <- gsub("million", "000000", nesrece$Škoda, ignore.case = TRUE)
nesrece$Škoda <- gsub("billion", "000000000", nesrece$Škoda, ignore.case = TRUE)
nesrece$Škoda<-gsub(" ", "", nesrece$Škoda)
nesrece$Škoda<-as.numeric(nesrece$Škoda)
nesrece$Smrtne.žrtve <- gsub(",", "", nesrece$Smrtne.žrtve)

#popravek1

nesrece$Smrtne.žrtve <- nesrece$Smrtne.žrtve %>%
  strapplyc("([0-9]+)") %>% lapply(as.numeric) %>%
  lapply(mean) %>% unlist()
nesrece$Smrtne.žrtve[is.nan(nesrece$Smrtne.žrtve)] <- NA

nesrece$Smrtne.žrtve<-as.integer(nesrece$Smrtne.žrtve)

povprecje<-mean(nesrece$Škoda, na.rm = TRUE )
stopnja<-character(nrow(nesrece))
stopnja[nesrece$Škoda<povprecje]<-"Manjša"
stopnja[nesrece$Škoda>povprecje]<-"Večja"
Stopnja_skode<-factor(stopnja,levels=oznaka,ordered=TRUE)
detach(nesrece)

nesrece<-data.frame(nesrece,Stopnja_skode)

attach(nesrece)
oznaka1<-c("Veliko","Malo")
stopnja1<-character(nrow(nesrece))
stopnja1[Smrtne.žrtve<=1000]<-"Malo"
stopnja1[Smrtne.žrtve>1000]<-"Veliko"
Stopnja_smrti<-factor(stopnja1,levels=oznaka1, ordered=TRUE)
detach(nesrece)


nesrece<-data.frame(nesrece,Stopnja_smrti)


#uvoz2(naravne nesreče, največ smrtnih žrtev)
naslov="https://en.wikipedia.org/wiki/List_of_disasters_in_the_United_States_by_death_toll"
stran <- html_session(naslov) %>% read_html(encoding="UTF-8")
tabela1 <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table()
tabela1$Type <- NULL
tabela1["Article"]<-NULL
tabela1["Damage (US$)"]<-NULL
#tabela1["Location"]<-NULL
tabela1["Comments"]<-NULL
tabela1$Fatalities <- gsub(",", "", tabela1$Fatalities)
tabela1$Fatalities<-gsub("\\+", "", tabela1$Fatalities)
tabela1$Fatalities<-gsub("\\(estimated)", "", tabela1$Fatalities)
tabela1$Fatalities<-gsub("to"," ", tabela1$Fatalities)
tabela1$Fatalities<-gsub("-"," ", tabela1$Fatalities)
tabela1$Fatalities<-strapplyc(tabela1$Fatalities, "^([0-9]+)") %>% unlist() %>% as.numeric()

attach(tabela1)
oznaka1<-c("Veliko","Malo")
stopnja1<-character(nrow(tabela1))
stopnja1[Fatalities<=1000]<-"Malo"
stopnja1[Fatalities>1000]<-"Veliko"
Stopnja_smrti<-factor(stopnja1,levels=oznaka1, ordered=TRUE)
detach(tabela1)


tabela1<-data.frame(tabela1,Stopnja_smrti)

ggplot(tabela1 %>% group_by(Year) %>% summarise(Fatalities = sum(Fatalities)) %>%
         filter(Fatalities >= 600),
       aes(x = factor(Year), y = Fatalities)) + geom_bar(stat = "identity") +
  coord_flip() + xlab("Year")

#uvoz tabele št.3 od BDP
naslov1="https://en.wikipedia.org/wiki/List_of_U.S._states_by_GDP_per_capita"
stran1 <- html_session(naslov1) %>% read_html(encoding="UTF-8")
tabelaBDP<- stran1 %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table(fill=TRUE)

tabelaBDP$Rank <- tabelaBDP$Rank %>% strapplyc("([0-9]+)") %>% as.numeric()
tabelaBDP$State <- tabelaBDP$State %>% strapplyc("([a-zA-Z ]+)") %>%
  unlist() %>% factor()
tabelaBDP[-c(1,2)] <- apply(tabelaBDP[-c(1,2)], 2,
                            . %>% {gsub(",", "", .)} %>% as.numeric())

tabelaBDP <- tabelaBDP %>%
  filter(!is.na(Rank) | grepl("District of Columbia", State))

#DODATEN STOLPEC ZA POVPREČJE
tabelaBDP$PovprecjeBDP <- apply(tabelaBDP[c(3:8)], 1, mean, na.rm = TRUE)


#nova tabela:povezava povprečni BDP z stopnjo škode


nesrece$Row <- 1:nrow(nesrece)
tabela_2 <- lapply(tabelaBDP$State, function(x) {
  r <- grep(x, nesrece$Lokacija)
  return(data.frame(State = rep(x, length(r)), Row = r))
}) %>% bind_rows() %>% as.data.frame() %>%
  inner_join(nesrece, by = "Row") %>%
  inner_join(tabelaBDP, by = "State") %>%
  select(Lokacija = State, Stopnja_skode,Stopnja_smrti, PovprecjeBDP)





