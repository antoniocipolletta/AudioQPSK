function [ trovami ] = gen_bit_start_stop( )
%   Genera il vettore di bit della sequenza di start e di quella di stop
%   che sono uguali.
%   Si basa sulla sequenza di Barker ottimizzata per 
%   la ricerca di una sequenza attraverso la correlazione.

v1 = [1,1,1,1,1,0,0,1,1,0,1,0,1];  % sequenza di Barker
v2 = zeros (1,52);
v3 = ones (1,4); 
for i = 0:12     
    
    v2 (i*4+1:i*4+4)= v3.*v1(i+1);     
                       
end

trovami = v2;

end

