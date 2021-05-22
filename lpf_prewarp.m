function [num den] = lpf_prewarp(fc,sample_rate)

%==========================================================================
%
% This is the function of calculating the coefficienet of low pass filter in 
% Z domain by prewarping.
%
% The function is defined as
%
%                   num(1) + num(2)*z^-1
%            H(z) = --------------------
%                   den(1) + den(2)*z^-1
%
% Input of the function
% fc         : Cut off frequency (in Hz)
% sample_rate: Sample rate (in Hz)
%
% Output of the function
% num: numerator of the transfer function
% den: denominator of the transder function
%
%==========================================================================

Ts          = 1/sample_rate;
num = tan(2*pi*fc*Ts/2)/(tan(2*pi*fc*Ts/2)+1) *[1 1];
den = [1 (tan(2*pi*fc*Ts/2)-1)/(tan(2*pi*fc*Ts/2)+1)];
