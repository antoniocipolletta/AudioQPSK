clear all
close all

file='shannon1.jpg';
f0=10e3;
fc=44.1e3;
nc = 20;
SNR_db = 0:50;
SNR_lin = 10.^(SNR_db/10);
ber=zeros(1, length(SNR_db));
tx=tx_wired_function(file,4,f0,fc);%vettore che contiene lo stream del file trasmesso
load('re20sha.mat');
Prx = var(rec); 
sigma = sqrt(Prx./(SNR_lin));
for i = 1:length(sigma)
   noise =  sigma(i)*randn(length(rec),1);
   rx = rec + noise';
   streamrx = rx_wired_function2(rx,f0,fc,nc);
   ber(i)=sum(abs(streamrx(1:length(tx))-tx))/length(tx);
end
plot(SNR_dB,log10(ber))
