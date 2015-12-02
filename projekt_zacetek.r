require(dplyr)
require(rvest)
require(gsubfn)

datoteka<-"podatki/1516501S.htm"

stran <- file(datoteka) %>% read_html(encoding="Windows-1250")
tabela <- stran %>% html_nodes(xpath="//table") %>% html_table() %>% .[[1]]
podatki <- as.numeric(tabela[3,-1]) %>% matrix(ncol=2)
