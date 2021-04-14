#Visualizzazione dati copernicus

library(raster)
install.packages("ncdf4")
library(ncdf4)
#la libreria "ncdf4" serve a leggere i file con estensione .nc
setwd("/Users/paolopatrizio/Desktop/lab")
lst_2021_04_01<-raster("c_gls_LST10-DC_202104010000_GLOBE_GEO_V2.0.1.nc")
cl<-colorRampPalette(c("red","pink","orange","yellow"))(100)
lst_2021_04_01_RES<-aggregate(lst_2021_04_01, fact=100)
#la funzione aggregate ci permette di ricampionare (resampling) un file cosi da aggregare più pixel attraverso una media dei loro valori che verranno visualizzati in uscita come un unico pixel. 
#questo tipo di ricampionamento si chiama ricampionamento bi-lineare, ci permette di alleggerire un file di quanto vogliamo (impostazione tramite fact (es.riduzione di un fattore 100)
plot(lst_2021_04_01_RES)
