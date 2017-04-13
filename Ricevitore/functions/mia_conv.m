function [ c ] = mia_conv( x,y )
% Correlazione tra segnali x e y partendo dalla piena sovrapposizione in
% testa
%   
c = zeros(length(x)-length(y),1);
for i = 1: length(c)
    c(i) = y*(x(i:(i+length(y)-1)))';
end


end

