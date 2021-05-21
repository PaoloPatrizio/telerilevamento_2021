library(raster)
library(RStoolbox)
library(ggplot2) # serve a plottare i ggplot
library(gridExtra) #serve a plottare i ggplot insieme
library(viridis) #la libreria viridis serve per colorare i plot di ggplot in modo automatico
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
plot(sentpca$map)
#come si può vedere dal plot la PC1 spiega la maggior parte della variabilità
sentpca
#all'interno dell'oggetto vediamo le sue caratteristiche quali la $call, il $model, la $map e gli attributi
pc1<-sentpca$map$PC1
pc1sd5<-focal(pc1,w=matrix(1/25,nrow=5,ncol=5),fun=sd)
### con la funzione "source" è possibile fornire come input uno script presente fuori da R 
source("source_test_lezione.r")
source("source.ggplot.r")
#creiamo una nuova finestra vuota con la funzione "ggplot" a cui noi aggiungeremo pezzi attraverso un semplice "+"
ggplot() + #con "ggplot()" creiamo una finestra vuota (rettangolo) dove inserire ciò che vogliamo
#???geom_raster VEDERE LEZIONE TEMPO 1 ora e 30
geom_raster(pc1sd5, mapping=aes(x=x,y=y,fill=layer))
#cosi si può capire che la zona con più ata variabilità territoriale è quella in alto a sinistra (nel nostro plot), variabilità dovuta alle carattaristiche molto eterogenee della geomorfologia
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() # con la funzione "scale_fill_viridis()" possiamo utilizzare color palette predefinite ed ottimali (anche aggiustate in funzione di disfunzioni visive)
### esercizio con diverse color_ramp_palette predefinite e titolo  
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="magma") +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno") +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")
#attraverso la funzione "grid.arrange" possiamo plottare assieme più plot (p1,p2,p3 in questo caso)
grid.arrange(p1,p2,p3, nrow=1)
