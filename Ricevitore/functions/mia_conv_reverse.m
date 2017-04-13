function [ c ] = mia_conv_reverse( x,y )
%Correlazione tra segnali x e y partendo dalla piena sovrapposizione in
% coda e tornando indietro.

c = zeros(length(x)-length(y),1);
j = 1;
for i = length(x) - length(y) : -1 : 1
    c(j) = y*(x(i:(i+length(y)-1)))';
    j = j+1;
end

end

