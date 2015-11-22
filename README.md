# Analiza podatkov 

Avtor: Valentina Pucer

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Kmetijstvo v Sloveniji

Analizirala bom podatke o kmetijstvu v Sloveniji. Najprej bom analizirala podatke 
o kmetijskih površinah v Sloveniji od leta 2000 do leta 2013(velikost posameznih tipov površin). 
V drugem delu pa bom analizirala še podatke o živinoreji v Sloveniji od leta 2000 do leta 2013(količina,..ipd.)

Skozi analizo podatkov želim izvedeti, koliko v Sloveniji pridelamo/smo pridelali in kako se to spreminja s časom.

Podatke sem dobila na internetu:

* `http://tradicionalni-zajtrk.si/media/uploads/public/_custom/projekti/Prehrambene_navade_odraslih_z_vidika_zdravja.pdf`

* `http://www.stat.si/statweb/Common/PrikaziDokument.ashx?IdDatoteke=5650`

* `statistični urad RS:
http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=1516501S&ti=&path=../Database/Okolje/15_kmetijstvo_ribistvo/03_kmetijska_gospod/01_15165_zemljisca/&lang=2`





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
