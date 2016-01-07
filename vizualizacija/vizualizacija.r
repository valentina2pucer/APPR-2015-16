# 3. faza: Izdelava zemljevida

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://wiki.potnik.si/images/thumb/2/27/zemljevid_Zdru%C5%BEenih_dr%C5%BEav_Amerike.gif/500px-zemljevid_Zdru%C5%BEenih_dr%C5%BEav_Amerike.gif"
                             , encoding = "Windows-1250")

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
druzine <- preuredi(druzine, zemljevid, "OB_UIME", c("Ankaran", "Mirna"))

# Izračunamo povprečno velikost družine.
druzine$povprecje <- apply(druzine[1:4], 1, function(x) sum(x*(1:4))/sum(x))
min.povprecje <- min(druzine$povprecje, na.rm=TRUE)
max.povprecje <- max(druzine$povprecje, na.rm=TRUE)

