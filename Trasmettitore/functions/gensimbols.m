function [ s, sign1, sign2 ,ts] = gensimbols( fc, file ,nc )
% Esegue la modulazione digitale del parametro file utilizzando un RZ antipodale
%   restituisce il simbolo base s utilizzato, due segnali che rappresentano
%   la modulazione di coppie di bit del parametro file ed il
%   tempo di simbolo utilizzato calcolato in base ad fc ed nc passati come
%   parametro.

ts = nc/fc;
s=[ones(1, ceil(nc/2)), zeros(1, nc-ceil(nc/2))];
file=file*2-1;
sign2=zeros(1, length(file)*nc/2);
sign1=sign2;
for i= 0 : (length(file)-1)
    if mod(i,2)==0
        sign1(i*nc/2+1:i*nc/2+nc)=s*file(i+1);
    else
        sign2(floor(i/2)*nc+1:floor(i/2)*nc+nc)=s*file(i+1);
    end
end
end
