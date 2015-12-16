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

#vsota povprečja stolpcev
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
# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.