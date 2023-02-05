% Initialization function for Delay block
% Make sure to understand the comments from the lab manual and have them
% here.


function [state_out,y] = delay(state_in,x)
s = state_in;
for ii = 0:length(x) - 1
    s.buff(s.n_t+1) = x(ii+1);
    s.n_t = bitand(s.n_t+1,s.Mmask);
end
y = zeros(size(x));

for ii = 0:length(y)-1
    y(ii+1) = s.buff(s.n_h+1);
    s.n.h = bitand(s.n_h+1,s.Mmask);
end
state_out = s;
