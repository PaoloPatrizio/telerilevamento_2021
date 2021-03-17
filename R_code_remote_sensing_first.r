# Il mio primo codice in R per il telerilevamento!
setwd("/Users/paolopatrizio/Desktop/lab/")
#la funzione setwd serve a richiamare una specifica cartella di lavoro (directory), nel nostro caso è "lab". bisogna utilizzare le virgolette perchè la cartella è esterna ad R.
library(raster)
#la funzione library permette di utilizzare un pacchetto precedentemente installato. Questo può essere fatto attraverso la funzione install.packages (es. install.packages("raster"))
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#attraverso la funzione brick noi possiamo importare in R i dati presenti in una cartella esterna (con cui abbiamo creato il collegamento tramite setwd). Attraverso la freccia possiamo associare il dato caricato ad un oggetto.
p224r63_2011
plot(p224r63_2011)
#tramite la funzione plot è possibile graficare l'oggetto caricato.
