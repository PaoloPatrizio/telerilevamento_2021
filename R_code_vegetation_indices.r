# R_code_vegetation_indices.r #
library(raster)
#una funzione equivalente di "library" è "require"
library(RStoolbox)
#RStoolbox è necessario al calcolo degli indici con la funzione "spectralIndices"
setwd("/Users/paolopatrizio/Desktop/lab")
defor1<-brick("defor1.png")
defor2<-brick("defor2.png")
#b1=NIR,b2=red,b3=green
par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")
dvi1<-defor1$defor1.1-defor1$defor1.2
#dvi1 è il risultato di un operazione algebrica che consiste nella sottrazione della banda rossa a quella dell'infrarosso vicino, il risultato è quindi una mappa che mostra i valori dell'indice DVI.
#dev.off()
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")
dvi2<-defor2$defor2.1-defor2$defor2.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")
difdvi <- dvi1 - dvi2
#difdvi ci mostra la differenza dell'indice DVI nei due periodi in cui l'abbiamo calcolata
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld, main="DVI temporal difference")
#l'NDVI = (NIR - RED)/(NIR + RED)
ndvi1<-(defor1$defor1.1 - defor1$defor1.2)/(defor1$defor1.1 + defor1$defor1.2)
#è importante inserire le parentesi per evidenziare dei "blocchi di calcolo" onde evitare errori nei sistemi sequenziali.
ndvi2<-(defor2$defor2.1 - defor2$defor2.2)/(defor2$defor2.1 + defor2$defor2.2)
par(mfrow=c(2,1))
plot(ndvi1, col=cl, main="1st NDVI")
plot(ndvi2, col=cl, main="2nd NDVI")
vi<-spectralIndices(defor1, green=3, red=2, nir= 1)
#attraverso la funzione "spectralIndices" possiamo impostare 
plot(vi, col=cl)
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
#dev.off()
plot(difndvi, col=cld)
#in rosso sono evidenziate le aree che hanno avuto la maggiore perdita in termini di NDVI
