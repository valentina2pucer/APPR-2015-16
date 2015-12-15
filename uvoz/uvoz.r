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
                    fileEncoding = "Windows-1250", header = FALSE,
                    na.strings = c("Unknown")))
}

cat("Uvažam podatke o naravnih nesrečah v ZDA...\n")
nesrece<-uvozi.nesrece()
nesrece$leto <- rep(NA, nrow(nesrece))
nesrece[60,-4] <- nesrece[58,-4]
prazne <- which(nesrece[,1] == "")
nesrece[prazne-1, "leto"] <- as.numeric(gsub("-", "", nesrece[prazne, 4]))
nesrece <- nesrece[-prazne,]

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine()

#obcine <- uvozi.obcine()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.