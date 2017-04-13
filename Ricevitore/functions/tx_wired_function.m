function [ stream ] = tx_wired_function( nomefile,nc,f0,fc )
% Genera il .wav che deve essere poi trasmesso (file + protocollo)
% Restituisce lo stream di bit che deve essere poi confrontato con quello
%   ricostruito al ricevitore per calcolare il BER.

fd = fopen(nomefile); %% descrittore del file
Acq = dec2bin(fread(fd)); %% acquisisco file in matrice Nbyte*8
dim = size(Acq); %% calcolo dimensione R*C
initialstream = reshape(Acq,dim(1)*dim(2),1); % creo unico flusso di char
initialstream = initialstream > 48; %% serve a convertire da char a logical
stream = initialstream;
initialstream = [1;1;initialstream]; %% prima parte del protocollo aggiungo
                                     %  due bit ad 1. 


start_stop = gen_bit_start_stop();

[s1,Itx,Qtx,ts] = gensimbols(fc,initialstream,nc); % modificare gen simbols
                                                  % per farle accettare nc

[s2,nstart] = gensimbols2(start_stop,fc,nc); % modificare gen simbols
                                                  % per farle accettare nc

t = 0:1/fc:(length(Itx)-1)/fc; % genero asse tempi
coseno = cos(2*pi*f0.*t); % genero coseno per la parte in fase
seno = sin(2*pi*f0.*t); % genero seno per la parte in quadratura
Ipb = Itx.*coseno; 
Qpb = Qtx.*seno;

Tx = Ipb + Qpb;
Tx = Tx/max(abs(Tx));

sec = 5;
tTs = t(1:sec*fc); % genero asse tempi per la sinusoide iniziale

start_stop_sin = cos(2*pi/ts.*tTs);

Tx = [start_stop_sin,nstart,Tx,nstart,start_stop_sin];

audiowrite(strcat(nomefile,'.wav'),Tx,fc);

end

