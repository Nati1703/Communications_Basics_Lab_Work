function [state_out, y] = fir(state_in, x);
% [state_out, y] = fir(state_in, x);
%
% Executes the FIR block.
%
% Inputs:
% state_in Input state
% x Samples to process
% Outputs:
% state_out Output state
% y Processed samples
% Get state
s = state_in;
% Move samples into tail of buffer
for ii = 0: s.Ns - 1
% Store a sample
s.buff(s.n_t+1) = x(ii+1); % storing the sample to the tail of circular buffer
% Increment head index (circular)
%% How exactly does this work??
s.n_t = bitand(s.n_t+1, s.Mmask);
s.ptr = bitand(s.n_t+s.Mmask, s.Mmask);% setting the temporary pointer to previous tail
sum = 0.0;
for j = 0:length(s.h)-1
sum = sum + s.buff(s.ptr+1)*s.h(j+1); % Output of the filter
s.ptr = bitand(s.ptr+s.Mmask, s.Mmask);
end
y(ii+1) = sum;
end
state_out = s;