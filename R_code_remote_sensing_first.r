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
