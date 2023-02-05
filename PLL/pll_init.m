function [state, y] = pll_init(f,D,k,w0,T)
%%Creates and initializes a new phase
% inputs :
%       f - Nominal ref.frequency
%       D - damping frequency
%       k - Loop again
%       w0 - loop carrier frequency
%       T - sample period
%       bfs - buffer size ?????????????????????????????????????
% Outputs: 
%       state - current/initial state
% add/save parameters
state.f = f;
state.D = D;
state.k = k;
state.w0 = w0;
%compute coefficients
tau1 = k/(w0*w0);
tau2 = 2*D/w0 - 1/k;
state.a1 = -(T - 2*tau1)/(T + 2*tau1);
state.b0 = (T + 2*tau2)/ (T + 2*tau1);
state.b1 = (T - 2*tau2)/(T + 2*tau1);
% lookup table 
state.sin_table = sin(2*pi*(linspace(0,1023 / 1024,1024)));
% Create initialized state ariables 
state.ym1 = 0;%???
state.vm1 = 0;
state.zm1 = 0;
state.vm1 = 0;
state.acc = 0;
% for amplitude modulation 
state.amplitude = 1;
end
