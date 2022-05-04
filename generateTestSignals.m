K=8;
W=1;
Nt=10000;

%function [signals, time]=generateTestSignals (K, W, Nt)
% generate signals for testing connectivity
%
% 64 electrodes as a set of two groups of 32 electrodes
% each group has one set of coupled source signals, 
% each output signal is a weighted sum of:
%    - the groups signal delayed for 0-2pi (uniformly for all group channels)
%    - its own unrelated signal
% the weight of group signal in defined by an input parameter, the own
% signals have weight 1.
% all the src signals are generated with "generateSignals"
% 
% input parameters:
%  K - a scalar coupling parameter - coupling strength
%  W - weight of coupled group signals
%  Nt - number of timesteps
%
% expectations:
% connectivity analisis should detect connectivity within each group but
% not between signals of different groups.


% Šverko, Z.; Sajovic, J.; Drevenšek, G.; Vlahini´c, S.; Rogelj, P. Generation of Oscillatory Synthetic Signal Simulating Brain Network
% Dynamics. In Proceedings of the 2021 44th International Convention on Information, Communication and Electronic Technology
% (MIPRO), MEET—Microelectronics, Electronics and Electronic Technology, Opatija, Croatia, 27 September–1 October 2021.
% ---------------------------------------------------------------------- 
% Copyright (2021): Zoran Šverko and Peter Rogelj
%-----------------------------------------------------------------------


omega0=2*pi*10;
beta=0.1*omega0;

dfi=0:2*pi/16:2*pi-0.01;
[sG1,fiG1,time] = generateSources(16,Nt,K,omega0,beta);
fiG1a=fiG1+dfi;
sG1a = cos(fiG1a);
[sG1b,fiG1b,time] = generateSources(16,Nt,0,omega0,2*beta);

[sG2,fiG2,time] = generateSources(16,Nt,K,omega0,beta);
fiG2a=fiG2+dfi;
sG2a = cos(fiG2a);
[sG2b,fiG2b,time] = generateSources(16,Nt,0,omega0,2*beta);

signals = [ sG1a + sG1b, sG2a + sG2b ];


%figure(1); plot(signals)

%plot signals one above the other
offset=4;
offsets = 31*offset : -offset : 0;
so=signals + offsets;
figure(2); plot(so)

figure('Name','Prikaz signala'); 
plot(so)
xlabel('Samples')
ylabel('Electrodes')
% set(gca,'YTick',1:offset:32*offset,'YTickLabel',{EC_318_b_pmc.chanlocs(1:1:end).labels})
set(gca,'YTick',1:offset:32*offset,'YTickLabel',{'32';'31';'30';'29';'28';'27';'26';'25';'24';'23';'22';'21';'20';...
    '19';'18';'17';'16';'15';'14';'13';'12';'11';'10';'9';'8';'7';'6';'5';'4';'3';'2';'1'})

