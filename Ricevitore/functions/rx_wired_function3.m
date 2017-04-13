function [ stream ] = rx_wired_function3( rec,f0,fc,nc )
% Permette di estrarre da un vettore di campioni, acquisito tramite la scheda audio, lo stream-bit del file ricevuto
% restituisce lo stream di bit del file ricevuto.

ts = nc/fc;                 %   calcolo tempo di simbolo con valore della 
                            %   frequenza di campionamento nominale

s=[ones(1, ceil(nc/2)), zeros(1, nc-ceil(nc/2))];

start_stop = gen_bit_start_stop(); %% bit delle sequenze di start e di stop 
                            
rx = cut_sinusoid(rec,fc); %% elimina silenzio
rx1 = remove_sin(start_stop,rx,fc,ts,f0, nc); %% elimina sinusoide in testa 
                                          %  ed in coda
rx = remove_start_stop(rx1,7); %% elimina sequenza di start e di stop

fnew = fcorrection(rx,f0,fc,length(rx)); %% correzione della frequenza
                                         %  attraverso ricerca della riga
                                         %  spettrale a maggior potenza
                                         %  più vicina  a quella nominale
                                         %  attesa pari a f0.
                                         %  fnew = fattore di correzione.

fnew = 0; % non è più necessario utilizzare la correzione statica iniziale
	  % poichè basta l'algoritmo dinamico utilizzato in fase di decodifica
f0 = f0 + fnew; %   correggo la frequenza nominale attraverso la correzione
                %   fnew. NON PIU' NECESSARIO.
                
t = 0:1/fc: (length(rx)-1)/fc; % asse tempi 
cose = cos(2*pi*f0.*t); % genero coseno di frequenza pari a f0 corretta.
sine = sin(2*pi*f0.*t); % genero seno di frequenza pari a f0 corretta.

Irx = 2*rx.*cose; % ottengo la componente in fase ( fattore 2 serve per un 
                  % riscalamento di potenza) 
Qrx = 2*rx.*sine; % ottengo la componente in quadratura ( fattore 2 serve 
                  % per un riscalamento di potenza) 

Irxfiltered = filterprova2(Irx,s); % filtro la componente in fase con un 
                                   % filtro matched. s è il simbolo base utilizzato 
Qrxfiltered = filterprova2(Qrx,s); % filtro la componente in fase con un 
                                   % filtro matched. s è il simbolo base utilizzato
                                   
[Irbit,Ircamp ,Qrbit,Qrcamp,ntiming,deltafi] = ...
                        xytobitswithtiming3(Irxfiltered,Qrxfiltered,fc,nc);

finalstream = group(Irbit,Qrbit)'; % accoppia i due vettori di bit per 
                                   % generare un unico stream di bit finale
                                   % che rappresenta il file ricevuto + i bit
                                   % ad 1 di protocollo
                                   
 % elimino i due bit ogni frame

 N = 50;
 k = 0;
 stream = zeros(length(finalstream),1);
 j = 1;
 i = 1;
 while i <= length(finalstream)
     if ( k == 0 )
        i = i+1;
        k = N;
     else
        k = k-1;
        stream(j) = finalstream(i);
        j = j+1;
     end
     i = i + 1;
 end
 
 stream = stream(1:j-1);
                                                 
end

