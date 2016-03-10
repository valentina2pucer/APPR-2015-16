# 4. faza: Analiza podatkov


nesrece$Row <- 1:nrow(nesrece)
tabela_1 <- lapply(tabelaBDP$State, function(x) {
  r <- grep(x, nesrece$Lokacija)
  return(data.frame(State = rep(x, length(r)), Row = r))
}) %>% bind_rows() %>% as.data.frame() %>%
  inner_join(nesrece, by = "Row") %>%
  inner_join(tabelaBDP, by = "State") %>%
  select(Lokacija = State, Stopnja_skode,Stopnja_smrti, PovprecjeBDP)



hist(tabela_1$PovprecjeBDP,
     
     main="Ali je povezava med stopnjo škode in smrti s povprečnim BDP lokacije?", 
     xlab="Lokacija", 
      col="grey",
     
     las=1)
     
     #prob=TRUE)