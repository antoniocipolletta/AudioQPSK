clear all
close all

file='shannon1.jpg';
f0=10e3;
fc=44.1e3;
nc = 20;
tx=tx_wired_function(file,4,f0,fc);% vettore che contiene lo stream del file trasmesso
load('re20sha.mat');
rx = rec;
logicrx = rx_wired_function3(rx,f0,fc,nc);
sum(abs(logicrx(1:length(tx))-tx))/length(tx)
