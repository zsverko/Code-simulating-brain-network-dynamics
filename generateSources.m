function [signals, fi , time] = generateSources(Nsrc,Nt,K, omega0, beta, omega_uniform)
%GENERATESOURCES generates sources by Kuramoto model
%  Nsrc - number of sources
%  Nt - number of time steps
%  K - a scalar coupling parameter - coupling strength
%    fi = theta_k is the phase of the k-th oscillator,
%    omega_k is the intrinsic frequency of the k-th oscillator,
% example:
% [signals, theta, t] = generateSources(64,10000,3)
% Nsrc=64; Nt=1000; K=3;


% Šverko, Z.; Sajovic, J.; Drevenšek, G.; Vlahini´c, S.; Rogelj, P. Generation of Oscillatory Synthetic Signal Simulating Brain Network
% Dynamics. In Proceedings of the 2021 44th International Convention on Information, Communication and Electronic Technology
% (MIPRO), MEET—Microelectronics, Electronics and Electronic Technology, Opatija, Croatia, 27 September–1 October 2021.
% ---------------------------------------------------------------------- 
% Copyright (2021): Zoran Šverko and Peter Rogelj
%-----------------------------------------------------------------------

Fs = 256 ;% sampling frequency in Hz

if nargin<4
    omega0 = 2*pi*10; % Central omega
end
if nargin<5
    beta=omega0* 0.25; %half-width of an interval containing the omegas. 
end
if nargin<6
    omega_uniform=0; % using uniform omega distribution or random one
end

% initialize omegas and initial phases:
if omega_uniform
    omega = omega0* ones(Nsrc,1) + beta*(-1:2/(Nsrc-1):1)';
    theta = (1:Nsrc)'/Nsrc * 2*pi; 
else
    omega = omega0* ones(Nsrc,1) + beta*(2*rand(Nsrc,1)-1);
    theta = rand(Nsrc,1) * 2*pi; 
end
% initialize oscilator phases:
 

% step by step computing
dt=1/Fs;
time=0:dt:(Nt-1)*dt;
fi = zeros(Nt,Nsrc);
fi(1,:) = theta;
for i=2:Nt
    d_theta =  omega - K/Nsrc* sum(sin(theta-theta'),2);
    theta = theta + d_theta*dt;
    fi(i,:)= theta;
end


signals = cos(fi);

%figure(1); plot(signals)
end

