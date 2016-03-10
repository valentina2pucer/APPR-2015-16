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
     aes(x=Factor(tabela_$Lokacija),
     main="Ali je povezava med stopnjo škode in smrti s povprečnim BDP lokacije?", 
     xlab="Lokacija", 
      col="grey",
     
     las=1,
     prob=TRUE)
lines(density(tabela_1$Stopnja_skode))
lines(density(tabela_1$Stopnja_smrti))  
     