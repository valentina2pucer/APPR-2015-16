library(knitr)
require(dplyr)
require(rvest)
require(gsubfn)
library(ggplot2)
library(plotrix)
library(shiny)
library(maps)
library(mapproj)




# Uvozimo funkcije za delo z datotekami XML.
source("lib/xml.r", encoding = "UTF-8")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")