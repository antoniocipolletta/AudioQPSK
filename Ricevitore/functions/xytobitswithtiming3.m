function [ Ibit,Icamp,Qbit,Qcamp,timing,deltafi_vect] = xytobitswithtiming3( I,Q,fc,nc )
% Dati il vettore delle componenti in fase ed in quadratura -> in bit
%   Sono racchiusi 2 algoritmi importanti:
%   1) L'aggancio in fase andando a calcolare di volta in volta la
%   differenza di fase tra il numero complesso ( I + iQ ) e il valore
%   ideale più vicino in fase. 
%   2) Il calcolo dinamico dell'istante di sampling ottimo attraverso
%   l'algoritmo del Late-Early. Il vettore timing ritornato rappresenta il
%   segnale di "attivazione" del campionatore/interprete.
    

    perfect = [angle(-1-1i), angle(-1+1i), angle(1-1i), angle(1+1i) ];
    Ibit = zeros(length(I),1); %inizializzo vettori
    Qbit = Ibit; %inizializzo vettori
    Icamp = Ibit; %inizializzo vettori
    Qcamp = Qbit;
    timing = Qcamp;
    j = 1;
    %count = nc/2;
    for i = 2 : nc/2
        ap = abs(I(i-1) + 1i*Q(i-1));
        an = abs(I(i+1) + 1i*Q(i+1));
        aa = abs(I(i) + 1i*Q(i));
        if ( aa > an && aa > ap )
            break
        end
    end
    count = i-1;
    deltafi = perfect(4)-angle(I(count+1) + 1i*Q(count+1));
    prev = 0;
    next = 0;
    deltafi_vect = zeros(length(I),1);
    N = 50; %% numero di bit all'interno di un frame prima dei due bit di 
            %  risincronizzazione
    N = N/2;
    k = 0;  % contatore per risincronizzazione
    deltafi_vect(1) = deltafi;
    for i = 1:length(I)
       if count == 1
           camp = (I(i) + 1i*Q(i));
           prev = abs(camp);
       end
       if ( count == 0 )
           if ( k == 0 ) 
              k = N+1;
              deltafi = perfect(4)-angle(I(i) + 1i*Q(i));
           end
           k = k-1;
           camp = I(i) + 1i*Q(i);
           camp = camp*exp(1i*deltafi);
           deltafi_vect(i-1) = deltafi*(1-1/nc);
           Icamp(j) = real(camp);
           Qcamp(j) = imag(camp);
           Ibit(j) = real(camp) > 0;
           Qbit(j) = imag(camp) > 0;
           deltafi = (perfect(Ibit(j)*2 + Qbit(j) + 1) - angle(camp)) + deltafi;
           j = j+1;
           count = nc;
           timing(i) = 1;
       end 
       if ( i > 1 && timing(i-1) == 1 )
           camp = (I(i) + 1i*Q(i));
           next = abs(camp);
           if prev > next
               count = count - 1;
           end
           if prev < next
               count = count + 1; 
           end
       end
       count = count - 1 ;
       if i > 1 && count > 0
        deltafi_vect(i) = deltafi_vect(i-1)*(1+1/nc); 
       end
    end
    
    Ibit = Ibit(1:j-1);
    Qbit = Qbit(1:j-1);
    Icamp = Icamp(1:j-1);
    Qcamp = Qcamp(1:j-1);
    
end
