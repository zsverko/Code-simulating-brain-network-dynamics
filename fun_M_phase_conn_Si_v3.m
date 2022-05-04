function M = fun_M_phase_conn_Si_v3(EEG)
% Calculation of brain connectivity indices
% Inputs:
%   EEG - structure, structure is same as produced with EEGLab
%
% Outputs:
%   M - matrix dimensions: (number of channels x number of channel x 7)
%       ,i.e.,matrix of connection between observed electrodes
%     - third dimension displays in order: PLI, PLV, IC, SC, wPLI, dwPLI,
%     absolute value of correlation
%


% Šverko, Z.; Sajovic, J.; Drevenšek, G.; Vlahini´c, S.; Rogelj, P. Generation of Oscillatory Synthetic Signal Simulating Brain Network
% Dynamics. In Proceedings of the 2021 44th International Convention on Information, Communication and Electronic Technology
% (MIPRO), MEET—Microelectronics, Electronics and Electronic Technology, Opatija, Croatia, 27 September–1 October 2021.
% ---------------------------------------------------------------------- 
% Copyright (2021): Zoran Šverko
%-----------------------------------------------------------------------

M_conn_matrix=zeros(EEG.nbchan,EEG.nbchan,7);


X=(hilbert(EEG.data'))';
phase_data=angle(X);
for i=1:EEG.nbchan
    el1=abs(X(i,:));
    for j=i:EEG.nbchan
            delta_pd=phase_data(i,:)-phase_data(j,:);
            
%             PLI=abs(mean(sign(unwrap(delta_pd))));
            cdd=X(i,:).*conj(X(j,:));
%             PLI=abs(mean(sign(imag(cdd))));
            M_conn_matrix(i,j,1)=abs(mean(sign(imag(cdd))));
            M_conn_matrix(j,i,1)=M_conn_matrix(i,j,1);
            
%             PLV=abs(mean(exp(1i*(delta_pd))));
            M_conn_matrix(i,j,2)=abs(mean(exp(1i*(delta_pd))));
            M_conn_matrix(j,i,2)=M_conn_matrix(i,j,2);
            
            
            
            SPEC1_IC=sum(X(i,:).*conj(X(i,:)));
            SPEC2_IC=sum(X(j,:).*conj(X(j,:)));
            SPECX_IC=sum(X(i,:).*conj(X(j,:)));
%             IC=abs(imag(SPECX_IC./sqrt(SPEC1_IC.*SPEC2_IC)));
            M_conn_matrix(i,j,3)=abs(imag(SPECX_IC./sqrt(SPEC1_IC.*SPEC2_IC)));
            M_conn_matrix(j,i,3)=M_conn_matrix(i,j,3);
            
            
            SPEC1_SC=mean(X(i,:).*conj(X(i,:)));
            SPEC2_SC=mean(X(j,:).*conj(X(j,:)));
            SPECX_SC=abs(mean(X(i,:).*conj(X(j,:)))).^2;
%             SC=SPECX_SC./(SPEC1_SC.*SPEC2_SC);
            M_conn_matrix(i,j,4)=SPECX_SC./(SPEC1_SC.*SPEC2_SC);
            M_conn_matrix(j,i,4)=M_conn_matrix(i,j,4);
            
            cdi=imag(cdd);
            
            
%             wPLI=abs(mean(abs(cdi).*sign(cdi))/mean(abs(cdi)));
            M_conn_matrix(i,j,5)=abs(mean(abs(cdi).*sign(cdi))/mean(abs(cdi)));
            M_conn_matrix(j,i,5)=M_conn_matrix(i,j,5);
            
            
            imagsum=sum(cdi);
            imagsumW=sum(abs(cdi));
            debiasfactor=sum(cdi.^2);
            
            
%             dwPLI=mean((imagsum.^2-debiasfactor)./(imagsumW.^2-debiasfactor));
            M_conn_matrix(i,j,6)=mean((imagsum.^2-debiasfactor)./(imagsumW.^2-debiasfactor));
            M_conn_matrix(j,i,6)=M_conn_matrix(i,j,6);
            
%           absolute value of correlation
            el2=abs(X(j,:));
            M_conn_matrix(i,j,7)=abs(corr(el1',el2'));
            M_conn_matrix(j,i,7)=M_conn_matrix(i,j,7);
            

    end
end



M=M_conn_matrix;

end

