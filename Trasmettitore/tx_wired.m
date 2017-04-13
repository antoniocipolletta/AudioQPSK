clear all;
close all;

f0 = 10000; %% 10kHz frequenza centrale di modulazione 
fc = 44100; %% 44.1kHz frequenza di campionamento nominale
nc = 4; %% numero di campioni per simbolo

nomefile='shannon1.jpg'; %% nomefile da trasmettere
fd = fopen(nomefile); %% descrittore del file
Acq = dec2bin(fread(fd)); %% acquisisco file in matrice Nbyte*8
dim = size(Acq); %% calcolo dimensione R*C
initialstream = reshape(Acq,dim(1)*dim(2),1); % creo unico flusso di char
initialstream = initialstream > 48; %% serve a convertire da char a logical in quanto 48 è il codice ASCII dello zero

N = 50; % numero di bit prima di aggiungere 2 uni per risincronizzare 
count = 0; %% Quando count = 0 allora inserisco due bit in più
stream = ... % alloco nuovo vettore
    zeros(length(initialstream) + floor(length(initialstream)/N),1);

j = 1;
for i = 1:length(initialstream)
    if ( count == 0 )
        count = N;
        stream(j) = 1;
        j = j+1;
        stream(j) = 1;
        j = j+1;
    end
    stream(j) = initialstream(i);
    j = j+1;
    count = count-1;
end



start_stop = gen_bit_start_stop();

[s1,Itx,Qtx,ts] = gensimbols(fc,stream,nc); % genero a partire da stream i 
                                            % vettori di simboli

[s2,nstart] = gensimbols2(start_stop,fc,nc); % genero la modulazione digitale
                                             % per la sequenza di bit di
                                             % taglio

t = 0:1/fc:(length(Itx)-1)/fc; % genero asse tempi
coseno = cos(2*pi*f0.*t); % genero coseno per la parte in fase
seno = sin(2*pi*f0.*t); % genero seno per la parte in quadratura

Ipb = Itx.*coseno; 
Qpb = Qtx.*seno;

Tx = Ipb + Qpb;
Tx = Tx/max(abs(Tx)); % normalizzo per poter scrivere file audio .wav

sec = 5;
tTs = t(1:sec*fc); % genero asse tempi per la sinusoide iniziale

start_stop_sin = cos(2*pi*f0/10.*tTs);

Tx = [start_stop_sin,nstart,Tx,nstart,start_stop_sin]; % concateno il segnale effettivo a quello di protocollo 

audiowrite(strcat(nomefile,'4v2.wav'),Tx,fc); % genero file audio
