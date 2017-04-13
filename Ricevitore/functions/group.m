function [ vect ] = group( signal1, signal2 )
%  	Prende due stream di bit e li raggruppa in modo alternato per generare un unico stream di bit
%  	I bit dello stream finale di posizione dispari ( considerando il primo bit il bit uno ) 
%	sono occupati dai bit del segnale signal1 e quelli di posizione pari sono occupati dai 
% 	bit di signal2.
    
    vect = zeros(2*length(signal1),1);
    j = 1;
    for i = 1:length(signal1)
        vect(j) = signal1(i);
        vect(j + 1) = signal2(i);
        j = j+2;
    end

end

