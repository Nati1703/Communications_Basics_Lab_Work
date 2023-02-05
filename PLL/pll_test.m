% test the PLL.
% Global Parameters
Nb = 10;
Ns = 100;
f = 0.1 ; k = 1; D = 1; w0 = 2*pi/100; T = 1;
% initialize PLL 
pll_state = pll_init(f, D, k, w0,T);
load('ref_800hz');

% generate random samples 
x = ref_in ;
%% reshape buffers
 xb = reshape(x, Ns , Nb);
%% for amplitude mdoulation 
for j = 1:1000
    x(j) = x(j) * 1;
end

 % output samples 
 y = zeros(Ns, Nb);
 % Process each buffer 
 for k = 1: Nb
     [state_out y(:,k)] = pll(pll_state, xb(:,k));
 end
 
% convert individual buffers back into a continous signal 
y_out = reshape(y, Ns*Nb, 1);
plot(n,x,'b',n, y_out, 'r');
