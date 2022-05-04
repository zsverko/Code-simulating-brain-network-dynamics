function fun_plot_conn_matrix_Si(connectivity_matrix,S_tfd)
% Drawing of connectivity matrix
% Inputs:
%   S_tfd - structure, structure is same as produced with EEGLab
%   connectivity_matrix - matrix of connection between observed electrodes
% Outputs:
%   figure with connectivity matrix representation
%


% Šverko, Z.; Sajovic, J.; Drevenšek, G.; Vlahini´c, S.; Rogelj, P. Generation of Oscillatory Synthetic Signal Simulating Brain Network
% Dynamics. In Proceedings of the 2021 44th International Convention on Information, Communication and Electronic Technology
% (MIPRO), MEET—Microelectronics, Electronics and Electronic Technology, Opatija, Croatia, 27 September–1 October 2021.
% ---------------------------------------------------------------------- 
% Copyright (2021): Zoran Šverko
%-----------------------------------------------------------------------



h=imagesc(connectivity_matrix);
% set(gca,'clim',[0 1],'xtick',1:1:EEG.nbchan,'xticklabel',{EEG.chanlocs(1:1:end).labels},'ytick',1:1:EEG.nbchan,'yticklabel',{EEG.chanlocs(1:1:end).labels},'fontsize', 6);
set(gca,'clim',[0 0.75]);

ax = ancestor(h, 'axes');
yrule = ax.YAxis;
% Change properties of the axes
ax.YTick = 1:1:S_tfd.nbchan;
ax.YTickLabel = {1:1:S_tfd.nbchan};
% Change properties of the ruler
yrule.FontSize = 8;
% % Change properties of the label
% yL.FontSize = 8;

xrule = ax.XAxis;
% Change properties of the axes
ax.XTick = 1:1:S_tfd.nbchan;
ax.XTickLabel = {1:1:S_tfd.nbchan};
% Change properties of the ruler
xrule.FontSize = 8;
% % Change properties of the label
% yL.FontSize = 8;
xtickangle(90)
axis square
colorbar
end

