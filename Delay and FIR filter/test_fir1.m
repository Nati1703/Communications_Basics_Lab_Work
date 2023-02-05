% test_fir1.m
%
% Script to test the FIR filter.
% Global parameters
Nb = 100; % Number of buffers
Ns = 128; % Samples in each buffer
% Generate filter coefficients
p.beta = 0.5;
p.fs = 0.1;
p.root = 0; % 0=rc 1=root rc
M = 64;
[h f H Hi] = win_method('rc_filt', p, 0.2, 1, M, 0);
% Generate some random samples.
x = randn(Ns*Nb, 1);
% Type of simulation
%Was it intentional that the flag stype was set to 1. Is there anyway to
%change it by means of input from the user.
stype = 1; % Do simple convolution
%stype = 1; % DSP-like filter
if stype==0,
 y = conv(x, h);% This is MATLAB provided function.
elseif stype==1,
 state_fir1 = fir_init(h,Ns);
 % Reshape into buffers
 xb = reshape(x, Ns, Nb); 
 % Output samples
 yb = zeros(Ns, Nb);
 % Process each buffer
 for bi=1:Nb
    [state_fir1 yb(:,bi)] = fir(state_fir1, xb(:,bi)); % Simple
 end
% Convert individual buffers back into a contiguous signal.
y = reshape(yb, Ns*Nb, 1);



else
 error('Invalid simulation type.'); % Don't know the exact reason, but incase the summation fails, it is a good idea to have that there. 
end

%% Honestly, don't know anything we did here. Try to ask around!
% Compute approximate transfer function using PSD
Npsd = 200; % Blocksize (# of freq) for PSD
[Y1 f1] = periodogram(y, [], Npsd, 1);
[X1 f1] = periodogram(x, [], Npsd, 1);
plot(f1, abs(sqrt(Y1./X1)), f, abs(H));
xlim([0 0.2]);
