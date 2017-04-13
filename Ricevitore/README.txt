Bisogna aggiungere al PATH di esecuzione di MATLAB la cartella functions che 
include le funzioni utilizzate.

RICEVITORE

Tutte le funzioni utilizzate sono incluse nella subfolder functions.


Lo script "Demo_re20sha.m" permette di effettuare una demo del funzionamento 
del ricevitore utilizzando una acquisizione salvata nel file "re20sha.mat".
Il numero di campioni per simbolo utilizzato è pari a 20.


Lo script "noise_test.m" utilizza l'acquisizione "re20sha.mat" per stressare il 
sistema al variare del rapporto segnale rumore del canale.

 
Lo script "rx_withrec.m" permette di effettuare un'acquisizione attraverso la scheda audio
e di generare lo stream di bit del file ricevuto.