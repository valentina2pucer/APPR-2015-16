# Analiza podatkov 

Avtor: Valentina Pucer
Mentor: asist. dr. Janoš Vidali

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Tematika

Za tematiko moje seminarske naloge sem si izbrala analizo podatkov naravnih nesreč v Združenih državah Amerike iz radovednosti, da izvem, v kakšnem obsegu so naravne nesreče na drugi strani sveta, koli denarne škode povzročijo..ipd.Naloge se bom lotila tako, da bom podatke iz spletne strani prenesla v program Microsoft Office Excel Worksheet in oblikovala tabelo, ki se bo od originalne razlikovala v tem, da bom nekaj odvečnih podatkov odstranila, nekaj dodala in uredila. Za vsak dogodek(katastrofo), bom podala:

*ta dogodek(imenska spremenljivka)

*lokacija(imenska spremenljivka ....(za zemljevid))

*leto, v katerem se je nesreča pripetila (številska spremenljivka)

*tip naravne nesreče, ki se je pripetila (imenska spremenljivka)

*število smrtnih žrtev(urejenostna smremenljivka (številska), HUDO, NI HUDO)

*denarna škoda(urejenostna,....VELIKA ŠKODA, MANJŠA ŠKODA)

Svoje podatke bom uvozila iz spletnega mesta:

https://en.wikipedia.org/wiki/List_of_natural_disasters_in_the_United_States

https://en.wikipedia.org/wiki/List_of_disasters_in_the_United_States_by_death_toll

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Spletni vmesnik

Spletni vmesnik se nahaja v datotekah v mapi `shiny/`. Poženemo ga tako, da v
RStudiu odpremo datoteko `server.R` ali `ui.R` ter kliknemo na gumb *Run App*.
Alternativno ga lahko poženemo tudi tako, da poženemo program `shiny.r`.

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `httr` - za pobiranje spletnih strani
* `XML` - za branje spletnih strani
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

