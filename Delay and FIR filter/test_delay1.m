% Revised on 5. April 2022
% Nathan Kassa
%n.kassa@jacobs-university.de
clear all;
close all;
clc;
Nb = 10;
Ns = 128;
Nmax = 200;
Nd = 10;
% Number of buffers
% Samples in each buffer
% Maximum delay
% Delay of block
% Initialize the delay block 
state_delay1 = delay_init(Nmax, Nd);
% Generate some random samples. 
x = randn(Ns*Nb, 1);
% Reshape into buffers
xb = reshape(x, Ns, Nb);
 % Output samples
yb = zeros(Ns, Nb);
% Process each buffer
for bi=1:Nb
[state_delay1 ,yb(:,bi)] = delay(state_delay1, xb(:,bi));
end
% Convert individual buffers back into a contiguous signal. 
y = reshape(yb, Ns*Nb, 1);
% Check if it worked right
n = (0:length(x)-1);
figure(1);
plot(n, x);
hold on;
plot(n, y);

figure(2);
plot(n+Nd, x, n, y, 'x');
% Do a check and give a warning if it is not right. Skip first buffer in check
 
% to avoid initial conditions. 
n_chk = 1+ [Ns:(Nb-1)*Ns-1];
if any(x(n_chk - Nd) ~= y(n_chk)), % don't know who provided the code here from last semester. Check this out.
warning('A mismatch was encountered.');
end