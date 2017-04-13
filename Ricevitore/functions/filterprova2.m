function [ vector ] = filterprova2( vect,s )
%   Filtro matched che si basa sulla convoluzione del segnale vect
%	con il simbolo base s che deve essere passato come parametro.
    
    vector = conv(vect,s);
    
    
end
