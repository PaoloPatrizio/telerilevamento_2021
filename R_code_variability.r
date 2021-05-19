library(raster)
library(RStoolbox)
setwd("/Users/paolopatrizio/Desktop/lab")
#la funz. "raster" viene usata solo quando si vuole caricare una sola banda (just 1 layer) mentre la funzione "brick" ci permette di caricare immagini composte da più bande
sent<-brick("sentinel.png")
#banda 1 = NIR; banda 2 = RED; banda 3 = GREEN
plotRGB(sent, stretch="lin") # di default -> r=1, g=2, b=3 -> in questo caso NIR è sul red, il RED è sul green ed il GREEN è sul blue
#le zone nere sono acqua, questa infatti assorbe buona parte della radiazione
#tanto più i dati sono dispersi (una distribuzione molto larga) e tanto più questi hanno una deviazione standard (varianza) elevata
#in un file raster si può assgnare un valore di deviazone standard ad ogni pixel in riferimento ad una finestra di pixel di riferimento per ogni pixel (es: varianza di un pixel considerando questo il centro di un quadrato 3px*3px
#si può quindi creare un'immagine della varianza per ogni banda
#in questo codice viene analizzata la varianza dell'NDVI (unico layer)
#assegnare un nome più comprensibile ed immediato alle bande del NIR e del RED cosi da semplificare il calcolo dell'NDVI
nir<-sent$sentinel.1
red<-sent$sentinel.2
ndvi <- (nir-red) / (nir+red)
#la componente più bassa è quella nera
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
plot(ndvi, col=cl)
w=window (moving window), viene ususalmente utilizzata una finestra quadrata per evitare anisotropia. bisogna inoltre ricordarsi che più grande è la finestra e più grande è il calcolo
#è importante he la moving window sia di lati dispari cosi da far capitare il valore computato al centro
ndvisd3 <- focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=sd) #1/9 significa che per il calcolo viene utilizzato ogni pixel dei 9 presi in considerazione
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)
### MEAN
ndvimean3 <- focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=mean)
plot(ndvimean3, col=clsd)
### finestra di calcolo più grande (minore risoluzione di calcolo)
ndvisd11 <- focal(ndvi,w=matrix(1/121,nrow=11,ncol=11),fun=sd)
plot(ndvisd11, col=clsd)
### PCA
sentpca <- rasterPCA(sent)
#nel $model vediamo quanta variabilità è spiegata dalle componenti elaborate -> la stessa cosa più altre caratteristiche del modello possno essereviste attraverso la fnzione "summary"
summary(sentpca$model)
#la prima componente spiega il 67% della variabilità mentre la seconda il 32%
