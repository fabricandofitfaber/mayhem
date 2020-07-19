---
title: Türkiye Mutluluk Endeksi Haritası
author: fabricandofitfaber
date: '2020-07-19'
slug: türkiye-mutluluk-endeksi-haritas
categories: []
tags: [r, ggplot2, maps]
---

# packages

install.packages("tidyverse")
install.packages("sp") # for spatial data
install.packages("map")
install.packages("mapproj")
install.packages("ggmap")
install.packages("DeducerSpatial")
install.packages("maps")

help(package = "maps")

## Loading required package: maps

require(maps)

map("usa") # map komutu harita ve poligon çizimi için kullanılıyor

map("county")

data(unemp) # data komutu yardımıyla R'ın içerisinde yer alan dataları enviromentimizie yüklüyoruz.
data(county.fips)

head(unemp) # datamızın ilk 6 satırını görmek için head komutunu kullanıyoruz.
head(county.fips)


colors <- c("#F1EEF6", "#D4B9DA", "#C994C7", "#DF65B0", "#DD1C77", "#980043")

unemp$colorBuckets <- as.numeric(cut(unemp$unemp, c(0, 2, 4, 6, 8, 10, 100)))
head(unemp)

colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]
map("county", col = colors[colorsmatched], fill = TRUE, resolution = 0, lty = 0, projection = "polyconic")
# Add border around each State
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 0.2, projection = "polyconic")
title("Eyaletlerin işsizlik oranı / Amerika, 2009")
leg.txt <- c("<2%", "2-4%", "4-6%", "6-8%", "8-10%", ">10%")
legend("topright", leg.txt, horiz = TRUE, fill = colors)

# Türkiye haritası için https://gadm.org/download_country_v3.html

require(tidyverse)

library(sp) # Konumsal (Spatial) veri için

tur <- readRDS("gadm36_TUR_1_sp.rds") # reading a spatial data
plot(tur)

tur@data %>%
  as_tibble() %>%
  head(10)

ggplot(tur, aes(x = long, y = lat)) +
  geom_polygon()

## Regions defined for each Polygons

ggplot(tur, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group)) +
  coord_fixed()

## Regions defined for each Polygons

tur_for <- fortify(tur) # Bu fonksiyon 'sp' paketinin içinde.

## Regions defined for each Polygons

head(tur_for) # her ilin lattitude ve longitude değerleri gösterililyor.

ggplot(tur_for) +
  geom_polygon(aes(x = long, y = lat, group = group),
    color = "white", fill = "red"
  ) +
  theme_void() +
  coord_fixed()

library(readxl)

mutluluk <- read_excel("mutluluk.xls")
head(mutluluk)

head(tur@data$NAME_1)

head(mutluluk$İl)

x <- "Ali Osman"
gsub("an", "on", x)

turkceden_ingilizceye <- function(dataset) {
  turkce_harfler <- c("Ç", "Ş", "Ğ", "İ", "Ü", "Ö", "ç", "ş", "ğ", "ı", "ü", "ö")
  ingilizce_harfler <- c("C", "S", "G", "I", "U", "O", "c", "s", "g", "i", "u", "o")
  dataset <- mgsub(turkce_harfler, ingilizce_harfler, dataset)
  return(dataset)
}

# Multiple gsub function

mgsub <- function(pattern, replacement, x, ...) {
  n <- length(pattern)
  if (n != length(replacement)) {
    stop("pattern and replacement do not have the same length.")
  }
  result <- x
  for (i in 1:n) {
    result <- gsub(pattern[i], replacement[i], result)
  }
  return(result)
}

tur@data$NAME_1 <- turkceden_ingilizceye(tur@data$NAME_1)
tur@data$NAME_1 <- gsub("K. Maras", "Kahramanmaras", tur@data$NAME_1)
tur@data$NAME_1 <- gsub("Kinkkale", "Kirikkale", tur@data$NAME_1)
tur@data$NAME_1 <- gsub("Zinguldak", "Zonguldak", tur@data$NAME_1)
tur@data$NAME_1 <- gsub("Afyon", "Afyonkarahisar", tur@data$NAME_1)

mutluluk$İl <- turkceden_ingilizceye(mutluluk$İl)

mutluluk %>% as_tibble()

id_and_cities <- data_frame(
  id = rownames(tur@data),
  İl = tur@data$NAME_1
) %>%
  left_join(mutluluk, by = "İl")

head(id_and_cities)

final_map <- left_join(tur_for, id_and_cities, by = "id")

head(final_map)

final_map <- final_map %>% 
  mutate(mutluluk = `Mutluluk düzeyi`)

ggplot(final_map) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = mutluluk), 
               color = "grey") +
  coord_map() +
  theme_void() +
  labs(title = "Türkiye'nin illere göre mutluluk indeksi-2015", 
       caption = "Kaynak: Türkiye Istatistik Kurumu") +
  scale_fill_distiller(name = "Mutluluk indeksi", 
                       palette = "Spectral", 
                       limits = c(0, 100), 
                       na.value = "white") +
  theme(plot.title = element_text(hjust = 0.5), 
        plot.subtitle = element_text(hjust = 0.5))
