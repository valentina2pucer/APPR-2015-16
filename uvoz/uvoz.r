# 2. faza: Uvoz podatkov

require(dplyr)
require(rvest)
require(gsubfn)
library(ggplot2)
library(dplyr)

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
#names(nesrece)<-gsub("\\.", " ",names(nesrece))
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

povprecje<-mean(nesrece$Škoda, na.rm = TRUE )
stopnja<-character(nrow(nesrece))
stopnja[nesrece$Škoda<povprecje]<-"Manjša"
stopnja[nesrece$Škoda>povprecje]<-"Večja"
Stopnja_skode<-factor(stopnja,levels=oznaka,ordered=TRUE)
detach(nesrece)

nesrece<-data.frame(nesrece,Stopnja_skode)


#uvoz2(naravne nesreče, največ smrtnih žrtev)
naslov="https://en.wikipedia.org/wiki/List_of_disasters_in_the_United_States_by_death_toll"
stran <- html_session(naslov) %>% read_html(encoding="UTF-8")
tabela1 <- stran %>% html_nodes(xpath ="//table[1]") %>% .[[1]] %>% html_table()
tabela1$Type <- NULL
tabela1["Article"]<-NULL
tabela1["Damage (US$)"]<-NULL
tabela1["Location"]<-NULL
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




