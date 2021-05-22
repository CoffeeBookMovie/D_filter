function [num,den] = notch(fcn,bwn,att,sample_rate)

%==========================================================================
%
% This program is for calculating the parameters of Notch filter.
% The filter is designed by the attenuation att at the centre frequency fcn
% and half of the attenuation at the centre frequency minus/plus half of the 
% bandwidth bwn by match pole-zero discretization.
%
% The modal is based on
%
%               1 + b*z^-1 + z^-2
%  H(s) = ----------------------------
%               1 + d*z^-1 + z^-2
%
% The filter is designed by 
%
% Resonance frequency fcn (Hz), for example, 500Hz
% Bandwidth Bwn (Hz), for example, 300Hz
% Attenuation Att (dB), for example, 20dB
% Sample rate (Hz), for example, 8000Hz
%
%==========================================================================

G  = 10^(-att/20);
Ts = 1/sample_rate;

b = pi*G^.5*bwn*(8*fcn^2-bwn^2)/(4*fcn^2-bwn^2);
c = (2*pi*fcn)^2;
d = pi*bwn*(8*fcn^2-bwn^2)/(4*fcn^2-bwn^2)/G^.5;

K = (1-2*exp(-d*Ts/2)*cos((4*c-d^2)^.5/2*Ts)+exp(-d*Ts))/(1-2*exp(-b*Ts/2)*cos((4*c-b^2)^.5/2*Ts)+exp(-b*Ts));

num = K*[1 -2*exp(-b*Ts/2)*cos((4*c-b^2)^.5/2*Ts) exp(-b*Ts)];
den =   [1 -2*exp(-d*Ts/2)*cos((4*c-d^2)^.5/2*Ts) exp(-d*Ts)];