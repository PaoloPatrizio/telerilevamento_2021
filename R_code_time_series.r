#Time series analysis
#Greenland increase of temperature
#data and code from Emanuela Cosma
library(raster)
setwd("/Users/paolopatrizio/Desktop/lab/greenland")
install.packages("rasterVis")
lst_2000<-raster("lst_2000.tif")
#all'interno del pacchetto Raster c'è una funzione chiamata "raster" che serve a creare un RasterLayer object (la funzione brick è invece utilizzata nel caso di multiple layers).
#l'utilizzo della funzione "raster" ci permette di importare in R i file (immagini) sottostanti.
lst_2005<-raster("lst_2005.tif")
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
rlist<-list.files(pattern="lst")
rlist
#la funzione "list.files" ci permette di creare una lista di files, racchiudibili tutti in un unico <oggetto> 
#il "pattern" è una scritta in comune tra i file che stiamo inserendo nella lista, questi vengono presi di default dalla working directory (setwd) e devono quindi presentare un carattere comune non condiviso con altri file.
import<-lapply(rlist,raster)
import
#"lapply" è una funzione che ci permette di applicare una funzione (ad esempio raster) ad una lista di file, queto ci permette di non ripetere l'operazione per ogni singolo file.
TGr<-stack(import)
TGr
#la funzione "stack" (interna al pacchetto raster) ci permette di unire diversi file in un unico file (questo ad esempio ci evita di utilizzare la funzione "par"). 
plotRGB(TGr,1,2,3,stretch="Lin")
#attraverso la funzione plotRGB possiamo plottare insieme (in modo sovrapposto) i file (1,2,3) prima riuniti in un unico file "RasterStack", i file corrisponderanno alle bande r,g e b, dipendentemente da come noi li inseriremo nel plotRGB.
#la predominanza di un colore rispetto agli altri nel plotRGB indica valori più alti di lst per il file a cui abbiamo associato il determinato colore.
