function [ rec_cut ] = cut_sinusoid( rec,fc )
% Questa funzione permette di eliminare il silenzio 
%   Si utilizza un metodo di "accensione a soglia" per eliminare il
%   silenzio all'inizio ed alla fine della registrazione. Si � utilizzato un
%   protocollo di framing che prevede l'invio di una sinusoide ad una
%   determinata frequenza per 5 secondi sia in testa al file che in coda.
%   Questo � stato introdotto poich� abbiamo osservato che alcune schede
%   audio utilizzano una sorta di fade-in che riduce quindi la
%   potenza del segnale nei primi istanti di trasmissione
%   portando ad una serie di problemi nella
%   stima del primo istante di decisione.

    threeshold = 0.9;
    ti = 0;
    tf = 0;
    arec = abs(rec);
    for i = 1: length(rec)
        if arec(i) > threeshold
            ti = i;
            break;
        end
    end
    for i = length(rec):-1:1 
        if arec(i) > threeshold
            tf = i;
            break;
        end
    end
    
    rec_cut = rec(ti+2*fc:tf-4*fc); % margine di tempo infatti fc come indice = 1 sec di registrazione
    

end
