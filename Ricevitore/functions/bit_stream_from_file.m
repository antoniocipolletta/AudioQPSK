function [ stream ] = tx_wired_function( nomefile)
% Restituisce lo stream di bit del file passato come parametro


fd = fopen(nomefile); %% descrittore del file
Acq = dec2bin(fread(fd)); %% acquisisco file in matrice Nbyte*8
dim = size(Acq); %% calcolo dimensione R*C
initialstream = reshape(Acq,dim(1)*dim(2),1); % creo unico flusso di char
initialstream = initialstream > 48; %% serve a convertire da char a logical
stream = initialstream;
end

