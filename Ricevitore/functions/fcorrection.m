function [ fnew ] = fcorrection( r,f0,fc, lun )
% Calcola la correzione di frequenza cercando l'armonica a più alta potenza
% nei pressi della frequenza nominale di modulazione ( banda passante ->
% f0).
%   
    
    B = 1e3; %1kHz di banda per il filtro stretto da applicare
    
    t = [0:1/fc:(lun-1)/fc ]; % asse tempi
    coseno = cos(2*pi*f0.*t); % genero coseno con frequenza nominale f0
    %sin = sin(2*pi*f0.*t); %g genero sin
    
    deltaf = fc/(lun); % calcolo risoluzione in frequenza
    f = -fc/2:deltaf:fc/2-deltaf; % asse frequenze
     
    G =  abs(f) <= B; % filter
    
    r1 = r.*coseno; % riporto in banda base il segnale cercando di recuperare la 
                    % componente in fase.
    
    R1 = fft(r1); 
    Rfiltered = fftshift(R1).*G; % applico il filtro in frequenza  
    decisore = abs(Rfiltered)/max(abs(Rfiltered)); % normalizzo rispetto al massimo
 
    for i = 1 : length(decisore)   % cerco il massimo che avendo normalizzato il vettore
                                   % avrà "ampiezza" pari ad 1
        if ( decisore(i) == 1 )
            fnew = f(i); 
            break;
        end
    end
    
    cos2 = cos(2*pi*(f0+deltaf).*t); % genero coseno alla nuova frequenza mi serve per controllare se 
                                     % il segno della correzione deve
                                     % essere positivo oppure negativo.
    r2 = r.*cos2;
    R2 = fft(r2);
    R2filtered = fftshift(R2).*G;   
    threshold2 = 0.8;
    decisore2 = abs(R2filtered)/max(abs(Rfiltered)) > threshold2;
    threeshold3 = 2;
    if  sum(decisore2) > threeshold3 
        fnew = -fnew;
    end
    
end

