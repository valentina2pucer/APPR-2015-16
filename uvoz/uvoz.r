# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
#uvozi.druzine <- function() {
  #return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      #row.names = 1,
                      #col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      #fileEncoding = "Windows-1250"))
#}
require(dplyr)
require(rvest)
require(gsubfn)

#uvoz1
uvozi.nesrece<-function(){
  return(read.csv2("podatki/podatki anpr.csv", sep=";", as.is = FALSE,
                    fileEncoding = "UTF-8", header = FALSE,
                    na.strings = c("Unknown"),
                   col.names=c("Leto","Tip naravne nesreče","Smrtne žrtve","Škoda","Dogodek","Lokacija","V7")
                   
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
names(nesrece)<-gsub("\\.", " ",names(nesrece))
nesrece <- nesrece[c("Leto","Lokacija","Tip naravne nesreče","Dogodek","Smrtne žrtve","Škoda")]

#filtracija
attach(nesrece)
nesrece$Škoda<-rep(NA)
oznaka<-c("Večja","Manjša")
povprecje<-as.numeric(mean(nesrece$Škoda))
stopnja<-character(nrow(nesrece))
stopnja[Škoda<povprecje]<-"Manjša"
stopnja[Škoda>povprecje]<-"Večja"
Stopnja_skode<-factor(stopnja,levels=oznaka,ordered=TRUE)
detach(nesrece)
dodatenstolpec<-data.frame(Stopnja_skode)
NESRECE<-data.frame(nesrece,Stopnja_skode)


#uvoz2(naravne nesreče, največ smrtnih žrtev)
naslov="https://en.wikipedia.org/wiki/List_of_disasters_in_the_United_States_by_death_toll"
stran <- html_session(naslov) %>% read_html(encoding="UTF-8")
#iz prve tabele število smrtnih žrtev, poleg leta, oznaka(ogromno, malo).3stolpci
#dva original, en dodan

