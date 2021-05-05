#LAND COVER CLASSIFICATION
library(raster)
library(Rstoolbox)
library(ggplot2)
#ggplot2 package needed
setwd("/Users/paolopatrizio/Desktop/lab")
defor1<-brick("defor1.png")
defor2<-brick("defor2.png")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#ggplot2 contiene la funzione ggRGB ###VEDERE PACCHETTO E FUNZIONE
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
#gridExtra package needed
#la funzione grid.arrange "mette insieme vari pezzi all'interno di un grafico" ovvero unisce due plot distinti in uno unico.
p1<-ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2<-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2, nrow=2)
