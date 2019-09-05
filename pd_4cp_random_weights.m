%  ------------------------------------------------------------------------
%  Peaks Detection : Random weights 
%  -------------------------------------------------------------------------
%  
%  Random weights initialization.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ======================== Assign Weights ================================

function w = pd_4cp_random_weights(w1, w2)

w = zeros(w2, 1 + w1);
delta = 0.12;
w = rand(w2, 1 + w1) * 2 * delta - delta;

end

% =========================================================================
%% End