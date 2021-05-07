#LAND COVER CLASSIFICATION
library(raster)
library(Rstoolbox)
library(ggplot2)
#ggplot2 package needed
library(gridExtra)
setwd("/Users/paolopatrizio/Desktop/lab")
defor1<-brick("defor1.png")
defor2<-brick("defor2.png")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#ggplot2 contiene la funzione ggRGB ###VEDERE PACCHETTO E FUNZIONE
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
#gridExtra package needed
p1<-ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2<-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2, nrow=2)
#la funzione grid.arrange "mette insieme vari pezzi all'interno di un grafico" ovvero unisce due plot distinti in uno unico.

### unsupervised classification (funct. = unsuperClass-> un tipo di classificazione in cui non vengono specificati i training sites, ciò ci permette di eliminare la soggettività dell'operatore e facilitare la replicabilità.
# nsamples= numero di campioni
d1c<-unsuperClass(defor1, nClasses=2)
d1c
#set.seed ci permette di raggiungere ogni volta lo stesso risultato sebbene la classificazione sia random. 
plot(d1c$map)
d2c<-unsuperClass(defor2, nClasses=2)
plot(d2c$map)
d2c3<-unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

## time series analysis 
#attraverso la funzione freq possiamo assegnare i pixel ad una o all'altra classe
freq(d1c$map)
s1=35261+306031
#s1 è uguale al numero totale dei pixel (visibile anche nelle carattersitiche dell'immagine
prop1<-freq(d1c$map)/s1
#attraverso questa operazione trasformiamo il numero di pixel assegnati ad ogni classe (frequenza) in proporzione (%)
s2 <- 342726
prop2<-freq(d2c$map)/s2
#CONCLUDERE CONTROLLANDO CHE LE CLASSI SIANO LE STESSE PER TUTTE E DUE LE IMMAGINI E COMPIERE IL CONFRONTO MATEMATICOO
#fattori = variabili categoriche (non numeri) 

## dataframe building
cover<-c("forest", "agricolture")
percent_1992<-c(89.66, 10.33)
percent_2006<-c(51.95, 48.05)
#la funzione data.frame ci permette di creare una tabella (il nostro dataset). si inseriscono prima i nomi delle colonne
percentages<-data.frame(cover, percent_1992,percent_2006)
percentages
#la funz. ggplot ci permette di plottarlo con le caratteristiche desiderate
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#per ordinare i plot uno di fianco all'altro possiamo utilizzare la funz. grid.arrange -> per fare cio dobbiamo associare i ggplot a degli oggetti (p1 e p2)   
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)
