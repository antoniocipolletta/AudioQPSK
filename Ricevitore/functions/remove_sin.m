function [ sign ] = remove_sin( start, vett, fc, Ts, f0 , nc)
% Permette di eliminare sinusoide in testa ed in coda al file ricevuto
%   Il protocollo di comunicazione prevede l'inserimento della sequenza
%   di Barker che ottimizza la ricerca attraverso correlazione.
%   La sequenza è stata trasmessa in banda base quindi con una modulazione
%   diversa rispetto a quella della SDU per favorire un "taglio" del
%   vettore il più preciso possibile al fine di migliorare il più possibile
%   la stima del primo istante di sampling. Il vettore restituito contiene
%   quindi la sequenza di start, la SDU e la sequenza di stop ( che è
%   identica a quella di start. 
[s,ntrovami] = gensimbols2(start,fc,nc);
c=mia_conv(vett, ntrovami);
m=max(abs(c));
c = abs(c) > 0.9*m;
[m, ti] = max(c);
c=mia_conv_reverse(vett, ntrovami);
m=max(abs(c));
c = abs(c) > 0.9*m;
[m, tf1]= max(c);
sign  = vett(ti:length(vett)-tf1+1);
end