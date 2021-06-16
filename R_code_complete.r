# R_code_complete_telerilevamento_geoecologico
#............................................................
# summary:
# 1. Remote sensing first code 
# 2. Time Series Analysis
# 3. Visualizzazione dati copernicus
# 4. Knitr
# 5. Multivariate Analysis 
# 6. Classification 
# 7. ggplot -> !!!
# 8. Vegetation Indices 
# 9. Land Cover Analysis (Time Series and classification)
# 10. Variability 
# 11. spectral signaturess

#............................................................

# 1. Remote sensing first code 
# Il mio primo codice in R per il telerilevamento!
setwd("/Users/paolopatrizio/Desktop/lab/")
#la funzione setwd (set working directory) serve a richiamare una specifica cartella di lavoro (directory), nel nostro caso è "lab". bisogna utilizzare le virgolette perchè la cartella è esterna ad R.
library(raster)
#la funzione library permette di utilizzare un pacchetto precedentemente installato. Questo può essere fatto attraverso la funzione install.packages (es. install.packages("raster"))
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#attraverso la funzione brick si possono importare in R i dati presenti in una cartella esterna (con cui abbiamo creato il collegamento tramite setwd). Attraverso la freccia possiamo associare il dato caricato ad un oggetto.
p224r63_2011
#inserendo il nome dell'oggetto possiamo visualizzare tutte le sue caratteristiche (ad esempio le bande di cui è composta una imagine).
plot(p224r63_2011)
#tramite la funzione plot è possibile graficare l'oggetto caricato.
cl <- colorRampPalette(c("black","grey","light grey"))(100)
# la funzione colorRampPalette serve ad indicare i colori con cui visualizzare il plot. è bene associare ogni funzione ad un nome. il numero finale fuori funzione serve a definire il numero di livelli, più livelli ci sono più sfumature ci saranno.
# la "C" prima dei colori serve ad identificare questi in un vettore
plot(p224r63_2011,col=cl)
#gli argomenti vanno sempre separati con la virgola. in questo caso la funzione plot è utilizzata per graficare gli argomenti: immagine e colori desiderati.
#l'oggetto "p224r63_2011" è un'immagine rilevata in diverse bande (sensori landsat): (B1,blu);(B2,verde);(B3,rosso);(B4,infrarosso vicino);(B5,infrarosso medio);(B6,infrarosso termico);(B7, infrarosso medio)
dev.off()
#questa funzione serve a chiudere un plot.
plot(p224r63_2011$B1_sre)
#il simbolo $ viene sempre utilizzato per legare due cose. in questo caso plottiamo l'immagine p224... ma solo con la banda B1_sre.
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#la funzione par serve a plottare determinate bande. proiettare due o più bande è detto multiframe (mf).
#attraverso "mfrow" possiamo decidere come visualizzare i determinati oggetti che stiamo plottando insieme -> (numero righe,numero colonne).
#si possono inserire prima le colonne con mfcol
#c viene posto davanti ai vettori (gruppi di oggetti) (vedi anche i colori in colorramppalette).
###
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
###
par(mfcol=c(2,2))
clb<-colorRampPalette(c("dark blue","blue","lightblue"))(100)
plot(p224r63_2011$B1_sre,col=clb)
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)
#attraverso questa serie di comandi noi possiamo plottare insieme un certo numero di bande ognuna con una determinata coloramppalette.
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
#la funzione plotRGB permette di proiettare insieme diverse bande, viene utilizzata anche per visuaizzare immagini con colori "reali". le bande per la visualizzazione dei colori reali devono essere montate cosi come fatto (3,2,1).
#la funzione stretch serve a visualizzare le bande inserite da 0 a 1, anche laddove queste non coprano tutto il campo da 0 a 1 
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
#in questo caso l'infrarosso vicino è montato sulla banda del rosso (e cosi viene visualizzato), il rosso su quella del verde ed il verde su quella del blu. la banda del blu viene cosi non considerata (si possono visualizzare solo 3 bande per volta).
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
#montando cosi le bande l'infrarosso vicino viene visualizzato come verde, la parte viola rappresenta invece il suolo nudo in questo tipo di montaggio.
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
#
par(mfcol=c(2,2))
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
#
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()
#attraverso la funzione "pdf" è possibile salvare all'interno di un pdf i successivi plot che inseriamo. il tutto va chiuso con dev.off().
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
#attraverso lo strecth "hist" è possibile stretchare ancora di più i valori centrali, permettendo cosi una visualizzazione ancora diversa (in questo caso si evidenziano meglio differenze all'interno del patch forestale).
#per gli studi di vegetazione l'infrarosso si usa di solito sull componente red, non c'è una visualizzazione migliore di altre. la visualizzazione migliore viene trovata empiricamente (esperienza fondamentale)
###
p224r63_1988 <- brick("p224r63_1988_masked.grd")
pdf("confronto_immagini_amazzonia.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
dev.off()
#plottaggio e salvataggio in PDF delle immagini in RGB del 1988 e 2011

#............................................................

# 2. Tome Series Analysis

#Time series analysis
#Greenland increase of temperature
#data and code from Emanuela Cosma
library(raster)
library(rasterVis)
setwd("/Users/paolopatrizio/Desktop/lab/greenland")
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
cl<-colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,col.regions=cl)
#levelplot ci fornisce un layout maggiormente chiaro rispetto al solo plot (in questo specifico caso), permettendoci una migliore analisi multitemporale.
#gli strati di una immagine stack si chiamano attributi (in TGr abbiamo 4 attributi: lst_20-00/05/10/15).
levelplot(TGr,col.regions=cl,names.attr=c("July 2000","July 2005","July 2010","July 2015"))
#è possibile modificare il layout del levelplot andando a modificare gli attributi negli argomenti della funzione levelplot. 
#nel caso specifico del rasterstack TGr, se si vogliono modificare i titoli delle immagini (di default uguali ai nomi dei singoli file) si agisce sull'argomento names.attr che serve a nominare i singoli attributi.
levelplot(TGr,col.regions=cl,main="LST variation in time",names.attr=c("July 2000","July 2005","July 2010","July 2015"))
#attraverso l'argomento "main" possiamo attribuire un titolo principale al nostro levelplot
#
### ESERCITAZIONE MELT GROENLANDIA ###
#
setwd("/Users/paolopatrizio/Desktop/lab/melt")
meltlist<-list.files(pattern="melt")
meltimport<-lapply(meltlist,raster)
melt<-stack(meltimport)
levelplot(melt)
melt_amount<-melt$X2007annual_melt - melt$X1979annual_melt
#per vedere le differenze tra file all'interno del nostro rasterstack "melt" possiamo utilizzare una operazione di matrix algebra, ad esempio possiamo operare una differenza tra il primo ed ultimo file temporale.
#essendo la differenza operata tra file interni ad un file più grande (il rasterstack melt) bisogna legarli a quest'ultimo con il $.
clb<-colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(melt_amount, col=clb)
#mentre con il plot l'argomento è "col", con il levelplot questo è col.regions

#............................................................

# 3. Visualizzazione dati copernicus

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

#............................................................

# 4. Knitr

setwd("/Users/paolopatrizio/Desktop/lab")
library(knitr)
stitch("R_code_greenland",template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#il pacchetto knitr permette di generare report

#............................................................

# 5. Multivariate Analysis 

library(raster)
library(RStoolbox)
setwd("/Users/paolopatrizio/Desktop/lab")
p224r63_2011<-brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre)
#l'ordine degli assi dipende da quale banda mettiamo prima
#pch-> point charachter, con questo argomento possiamo scegliere il layout dei punti graficati ###VEDERE LEZIONE PER ARGOMENTI(28/04)###
pairs(p224r63_2011)
#pairs è una funzione che ci permette di plottare tutte le correlazioni possibili di molte variabili -> mette in correlazione due a due tutte le variabili di un dataset (esempio: correlazione tra 7 bande)
p224r63_2011res<-aggregate(p224r63_2011, fact=10)
#essendo il file pesante, prima di svolgere la PCA possiamo ricampionare (resample) l'immagine attraverso la funzione "aggregate", ciò ci permette di ridurre la dimensione del file riducendone la risoluzione.
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
#attraverso questi due plottaggi può essere evidenziata la differenza tra l'immagine ricampionata e l'originale
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
#la funzione "rasterPCA" prende il nostro pacchetto di dati e va a compattarli in un numero minore di bande. il risultato di questa funzione è un modello ed una mappa.
summary(p224r63_2011res_pca$model)
#la funzione summary fornisce un sommario del nostro modello ($model), in questo caso il modello è quello generato con la funzione rasterPCA. In tal modo possiamo capire in che proporzioni le bande (componenti) spiegano la varianza.
#la prima componente è sempre quella che spiega la maggiore variabilità (proportion of variance)
plotRGB(p224r63_2011res_pca$map, r=1,g=2,b=3,stretch="lin")
#per visualizzare l'immagine dopo l'analisi multivariata bisogna legarla a map ($map), cosi come fatto per visualizzare il sommario del modello ($model)
###SPOSTARE SPIEGAZIONE SET.SEED###
#la funzione "set.seed" può essere utilizzata per ottenere sempre lo stesso risultato dalle funzioni che possono portare una certa variabilità nella ripetizione dell'operazione.
###VEDERE FINE LEZIONE PER UTILIZZO ANALISI MULTIVARIATA###

#............................................................

# 6. Classification 

library(raster)
#necessitiamo della libreria raster per utilizzare la funzione brick ai fini di importare in R l'immagine desiderata (composta da 3 layers)
library(RStoolbox)
setwd("/Users/paolopatrizio/Desktop/lab")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#plotRGB ci permette di visualizzare questo tipo di immagine elaborata sulla base dei 3 livelli. 
so
#un pixel viene assegnato ad una classe di appartanenza rispetto alla riflettanza nelle varie bande (se più vicina alla rilettanza tipica di una vegetazione viene assegnato a quella classe).
#ciò viene fatto attraverso una classificazione non-supervisionata-> compiuta attraverso i training-set (pixel guida scelti dal software) il cui numero è fissato dall'operatore, cosi come il numero delle classi (separatamente)
soc<-unsuperClass(so,nClasses=3)
plot(soc$map)
#questo plottaggio ci permette di visualizzare le classi rispetto all'immagine analizzata
set.seed(42)
#SCRIVERE QUI FUNZIONE SET.SEED
#in questo tipo di algoritmo di classificazione viene considerata solamente la riflettanza, ci sono invce altre classificazioni che possono identificare anche forme diverse. 
###
#Grand Canyon
###
library(raster)
library(RStoolbox)
setwd("/Users/paolopatrizio/Desktop/lab")
GC<- brick("dolansprings_oli_2013088_canyon_lrg.JPG")
plotRGB(GC,r=1,g=2,B=3, stretch="lin")
#plotRGB pemette di plottare un file raster composto da più layer
GCC2<-unsuperClass(GC,nClasses=2)
#la funzione unsuperclass ci permette di svolgere una classificazione non-supervisionata
plot(GCC2$map)
#se fosse disponibile anche la banda dell'infrarosso (cosa che non è perchè l'immagine è disponibile con le tre bande RGB) allora l'acqua potrebbe essere identificata in una classe differente.

#............................................................

# 7. ggplot -> see R_code_variability

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#............................................................ 

# 8. Vegetation Indices 

# R_code_vegetation_indices.r #
library(raster)
#una funzione equivalente di "library" è "require"
library(RStoolbox)
#RStoolbox è necessario al calcolo degli indici con la funzione "spectralIndices"
#installare il pacchetto "rasterdiv" se non già presente
library(rasterdiv)
library(rasterVis)
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
###WORLDWIDE NDVI -> 
plot(copNDVI)
#copNDVI è un dataset gratuito già presente nella vignette del pacchetto rasterdiv    
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#la funzione di riclassificazione può essere utilizzata, in questo caso, per assegnare a pixel di determinati valori un valore nullo (NA)
#con "cbind" scegliamo di assegnare un valore nullo ai pixel che hanno valori da 253 a 255
levelplot(copNDVI)

#............................................................ 

# 9. Land Cover Analysis (Time Series and classification)

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

#............................................................

# 10. Variability 

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

#............................................................

# 11. spectral signaturess

library(raster)
library(rgdal)
setwd("/Users/paolopatrizio/Desktop/lab")
defor2<-brick("defor2.png")
plotRGB(defor2, 1,2,3,stretch="lin") # si può anche applicare uno stretch a istogramma ("hist")
#con la funzione click riusciamo ad ottenere le informazioni dell'immagine operando un semplice click sull'immagine, gli argomenti riguardano le caratteristiche che vogliamo osservare
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="green")
# xy= informazione spaziale; cell= numero pixel, type= tipo di punto rappresentato 

## results 
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 151.5 275.5 144986      205        9       23
#      x    y   cell defor2.1 defor2.2 defor2.3
# 1 405.5 93.5 275734       79       63       92
      x     y   cell defor2.1 defor2.2 defor2.3

#creiamo vettori con i valori investigati tramite la funzione click
band <-c(1,2,3)
forest <-c(205,9,23)
water <-c(79,63,92)
# creiamo una tabella con la funzione data.frame
spectral_s<-data.frame (band, forest, water)
# plottiamo le firme spettrali con ggplot, per fare questo dobbiamo impostare dei parametri quali gli assi (asse X= bande, asse Y= riflettanza)
ggplot(spectral_s, aes(x=band)) +
geom_line(aes(y=forest), color="green") +
geom_line(aes(y=water), color="blue") +
labs(x="band", y="reflectance")

####### multitemporal analysis
defor1<-brick("defor1.png")
plotRGB(defor1, 1,2,3,stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="green")
## results for defor1
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 208.5 316.5 115646      153        0       25
# 2 258.5 310.5 119998      159      150      133
# 3 297.5 321.5 112150      204      182      169
# 4 291.5 355.5  87766      219      118      124
# 5 267.5 361.5  83440      212      173      176
# 6 217.5 370.5  76937      201      144      137

## results for defor2
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 241.5 320.5 112811      158      163      143
# 2 282.5 323.5 110701      184      135      138
# 3 303.5 318.5 114307      170      164      150
# 4 294.5 346.5  94222      198      207      188
# 5 270.5 343.5  96349      186      166      157
# 6 205.5 348.5  92699      166      154      140

band<- c(1,2,3)
time1<- c(159,150,133)
time2<- c(184,135,138)

spectral_st<-data.frame(band,time1,time2)

ggplot(spectral_s, aes(x=band)) +
geom_line(aes(y=time1), color="pink") +
geom_line(aes(y=time2), color="red") +
labs(x="band", y="reflectance")

## possiamo fare la stessa cosa generando punti casuali (vedere lezione ore 10:30)  e poi estraendoli (extract)
jp <- brick("june_puzzler.jpg")
plotRGB(jp, 1,2,3,stretch="lin")
click(jp, id=T, xy=T, cell=T, type="p", pch=16, col="green")
#      x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
# 1 141.5 145.5 240622             40            139              0
# 2  71.5 438.5  29592            232            228             35
# 3 548.5 283.5 141669             32             17             10

band<- c(1,2,3)
point1<- c(40,139,0)
point2<- c(232,228,35)
point3<- c(32,17,10)

spectral_jp <- data.frame(band,point1,point2,point3)

ggplot(spectral_jp, aes(x=band)) +
geom_line(aes(y=point1), color="pink") +
geom_line(aes(y=point2), color="red") +
geom_line(aes(y=point3), color="dark red") +
labs(x="band", y="reflectance")
