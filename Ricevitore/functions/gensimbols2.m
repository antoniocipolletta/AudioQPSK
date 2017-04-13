function [ s, sign1 ,ts] = gensimbols2( signal,fc,nc )
% Esegue la modulazione digitale del parametro signal utilizzando un NRZ
% unipolare
%   restituisce il simbolo base s utilizzato, il segnale modulato ed il
%   tempo di simbolo utilizzato calcolato in base ad fc ed nc passati come
%   parametro.

    ts = nc/fc;
    s = [ones(1,nc)];
    file=signal;
    sign1=zeros(1, nc*length(file));
    for i= 0 : (length(file)-1)
        sign1(nc*i+1:nc*i+length(s))=s*file(i+1);
    end
end