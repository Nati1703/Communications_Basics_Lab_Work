function [state] = delay_init(Nmax, N);
%% 1. Save parameters
state.Nmax = Nmax;
% Store initial desired delay.
state.N = N;
%% 2. Create state variables
% Make the size of the buffer at least twice of the maximum delay. % Allows us to copy in and then read out in just two steps. 
state.M = 2^(ceil(log2(Nmax))+1);
% Get mask allowing us to wrap index easily
state.Mmask = state.M-1;
% Temporary storage for circular buffer 
state.buff = zeros(state.M, 1);
% Set initial head and tail of buffer 
state.n_h = 0;
state.n_t = N; % Here, I believe we want to move the whole sequence usually in DSP, so the N should also correspond to that. 
end