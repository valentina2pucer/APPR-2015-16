# Analiza podatkov s programom R, 2015/16

Avtor: Valentina Pucer

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Tematika
Moja tema bo v povezavi s prehranjevanjem oz. s prehranjevalnimi navadami ljudi v Sloveniji.Podatke sem dobila na internetu:

-http://tradicionalni-zajtrk.si/media/uploads/public/_custom/projekti/Prehrambene_navade_odraslih_z_vidika_zdravja.pdf

-http://www.stat.si/statweb/Common/PrikaziDokument.ashx?IdDatoteke=5650
Cilj je, seznaniti sebe in ostale s podatki glede prehranjevalnih navad Slovencev, saj je to v današnjem svetu vse bolj pomembna tema.

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
