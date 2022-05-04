clc;clear all;close all;
% Šverko, Z.; Sajovic, J.; Drevenšek, G.; Vlahini´c, S.; Rogelj, P. Generation of Oscillatory Synthetic Signal Simulating Brain Network
% Dynamics. In Proceedings of the 2021 44th International Convention on Information, Communication and Electronic Technology
% (MIPRO), MEET—Microelectronics, Electronics and Electronic Technology, Opatija, Croatia, 27 September–1 October 2021.
% ---------------------------------------------------------------------- 
% Copyright (2021): Zoran Šverko
%-----------------------------------------------------------------------

load('ukupni_signal.mat')
clear signals % because the variable named "signals" is in ukupni_signal.mat represent only the one signal (one channel signal)
signals=mean(UK,3)';
signals=mean(UK(:,:,100),3)';


offset=7;
offsets = 31*offset : -offset : 0;
so=signals + offsets;

figure('Name','Prikaz signala'); 
plot(so)
title('Signals')
xlabel('Samples')
ylabel('Electrodes')
% set(gca,'YTick',1:offset:32*offset,'YTickLabel',{EC_318_b_pmc.chanlocs(1:1:end).labels})
set(gca,'YTick',1:offset:32*offset,'YTickLabel',{'32';'31';'30';'29';'28';'27';'26';'25';'24';'23';'22';'21';'20';...
    '19';'18';'17';'16';'15';'14';'13';'12';'11';'10';'9';'8';'7';'6';'5';'4';'3';'2';'1'})

subplot(1,3,1)
% figure('Name','Signals at the beginning'); 
plot(so(1:1000,:))
title('Signals at the beginning','FontSize',18)
% xlabel('Samples')
ylabel('Electrodes','FontSize',16)
% set(gca,'YTick',1:offset:32*offset,'YTickLabel',{EC_318_b_pmc.chanlocs(1:1:end).labels})
set(gca,'YTick',1:offset:32*offset,'YTickLabel',{'32';'31';'30';'29';'28';'27';'26';'25';'24';'23';'22';'21';'20';...
    '19';'18';'17';'16';'15';'14';'13';'12';'11';'10';'9';'8';'7';'6';'5';'4';'3';'2';'1'},'XTick',0:200:1000,'XTickLabel',{'0';'200';'400';'600';'800';'1000'},...
    'FontSize',12)
ylim([-10 230])

subplot(1,3,2)
% figure('Name','Signals in the middle'); 
plot(so(4501:5500,:))
title('Signals in the middle','FontSize',18)
xlabel('Samples','FontSize',16)
% ylabel('Electrodes')
% set(gca,'YTick',1:offset:32*offset,'YTickLabel',{EC_318_b_pmc.chanlocs(1:1:end).labels})
set(gca,'YTick',1:offset:32*offset,'YTickLabel',{'';'';'';'';'';'';'';'';'';'';'';'';'';...
    '';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';''},'XTick',0:200:1000,'XTickLabel',{'4500';'4700';'4900';'5100';'5300';'5500'},...
    'FontSize',12)
ylim([-10 230])

subplot(1,3,3)
% figure('Name','Signals at the end'); 
plot(so(9001:10000,:))
title('Signals at the end','FontSize',18)
% xlabel('Samples')
% ylabel('Electrodes')
% set(gca,'YTick',1:offset:32*offset,'YTickLabel',{EC_318_b_pmc.chanlocs(1:1:end).labels})
set(gca,'YTick',1:offset:32*offset,'YTickLabel',{'';'';'';'';'';'';'';'';'';'';'';'';'';...
    '';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';'';''},'XTick',0:200:1000,'XTickLabel',{'9000';'9200';'9400';'9600';'9800';'10000'},...
    'FontSize',12)
ylim([-10 230])


%% initialization - creating a structure
EEG_begin.data=signals(1:1000,:)';
EEG_begin.nbchan=size(EEG_begin.data,1);
EEG_middle.data=signals(4501:5500,:)';
EEG_middle.nbchan=size(EEG_middle.data,1);
EEG_kraj.data=signals(9001:10000,:)';
EEG_kraj.nbchan=size(EEG_kraj.data,1);

%% calculation of connectivity indices for each region
CM_begin=fun_M_phase_conn_Si_v3(EEG_begin);
CM_middle=fun_M_phase_conn_Si_v3(EEG_middle);
CM_kraj=fun_M_phase_conn_Si_v3(EEG_kraj);


b=CM_begin(:,:,2); % for PLV
b(b==1)=0; % values ​​on the diagonal of the matrix set to zero
m=CM_middle(:,:,2); % for PLV
m(m==1)=0; % values ​​on the diagonal of the matrix set to zero
e=CM_kraj(:,:,2); % for PLV
e(e==1)=0; % values ​​on the diagonal of the matrix set to zero

%% Drawing
figure('Name','PLV at the beginning')
fun_plot_conn_matrix_Si(b,EEG_begin)
title('PLV at the beginning')

figure('Name','PLV in the middle')
fun_plot_conn_matrix_Si(m,EEG_middle)
title('PLV in the middle')

figure('Name','PLV at the end')
fun_plot_conn_matrix_Si(e,EEG_kraj)
title('PLV at the end')


figure('Name','PLI at the beginning')
fun_plot_conn_matrix_Si(CM_begin(:,:,1),EEG_begin)
title('PLI at the beginning')

figure('Name','PLI in the middle')
fun_plot_conn_matrix_Si(CM_middle(:,:,1),EEG_middle)
title('PLI in the middle')

figure('Name','PLI at the end')
fun_plot_conn_matrix_Si(CM_kraj(:,:,1),EEG_kraj)
title('PLI at the end')