clear all
close all
% % parto ricevendo un vettore di campioni
 nc = 20;    %   numero di campioni per simbolo -> 
             %   da regolare in base al bitrate
             %   ovviamente bisogna regolare allo stesso modo il Tx per 
             %   generare un file audio adeguato
 f0 = 10000; %% 10kHz frequenza centrale di modulazione 
 fc = 44100; %% 44.1kHz frequenza di campionamento nominale
sec = 45; %% secondi di registrazione da regolare in base a durata file
N_bit = 24; %% comune nella maggior parte delle schede audio
N_channel = 1;
obj = audiorecorder(fc,N_bit,N_channel); % instanzio oggetto per acquisire dati
disp('Inizio recording'); % stampa frase -> mettere in play file al Tx
recordblocking(obj, sec);
disp('Fine recording'); % stampa frase -> inizio processing
rec = getaudiodata(obj)';

finalstream = rx_wired_function3(rec,f0,fc,nc);
file='idseb.jpeg';
tx=tx_wired_function(file,4,f0,fc);%vettore che contiene lo stream del file trasmesso
sum(abs(finalstream(1:length(tx))'-tx));