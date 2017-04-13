function [ vect ] = remove_start_stop( rx, N )
%Eliminazione sequenza di start e di stop
%   Elimina la sequenza di start ( non ancora provato efficienza
%   anche quella distop) attraverso un conteggio di attraversamenti di 
%   soglia.
%   E' possibile eseguire questo tipo di processing essendo nota a priori la
%   sequenza mandata. CRITICITA' : A causa di un effetto di distorsione di 
%   fase potrebbe essere che la soglia non sia ben scelta
%   P.s. con N si indica il numero di attraversamenti e viene passato come
%   Parametro
    K = 60;
    L = 1500;
    %vect = rx(K:L);
    %vect = rx;
    %vect = abs(vect);
    threshold = 0.5;
    flag = rx(K) > threshold;
    count = 0;
    vect = rx(K:length(rx));
    for i = 1:length(vect)
        if flag == 1
            if  vect(i) < threshold
                flag = 0;
                count = count + 1;
            end
        else
            if  vect(i) > threshold
                flag = 1;
                count = count + 1;
            end
        end
        if count >= N
            break;
        end
    end
    initial = i;
    flag = 0;
    count = 0;
    for i = length(vect):-1:1
        if flag == 1
            if  vect(i) < threshold
                flag = 0;
                count = count + 1;
            end
        else
            if  vect(i) > threshold
                flag = 1;
                count = count + 1;
            end
        end
        if count >= N
            break;
        end
    end
    term = i;
    vect = rx(initial+K-1:length(rx));
end