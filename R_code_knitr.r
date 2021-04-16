#R_code_knitr.r

setwd("/Users/paolopatrizio/Desktop/lab")
library(knitr)
stitch("R_code_greenland",template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#il pacchetto knitr permette di generare report
