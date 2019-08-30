%  ------------------------------------------------------------------------
%  Peak Detection : Find respetive classes.
%  ------------------------------------------------------------------------
%  
% This script analyzes the input signal and assign a class-value to it.
%
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [desired_output_class] = pd_4cp_findClass(signal)

%% =================== Get the desired output class =======================

nn_signal_window = signal;
nn_signal_length = length(nn_signal_window);

window_left = nn_signal_window(1:floor(nn_signal_length/2));
window_right = nn_signal_window(ceil(nn_signal_length/2)+1:end);

left_slope = pd_4cp_getSlope(window_left);
right_slope = pd_4cp_getSlope(window_right);

window_shape = [left_slope, right_slope];

if window_shape == [1, 1]
    desired_output_class = 1;
elseif window_shape == [1, -1]
    desired_output_class = 2;
elseif window_shape == [-1, -1]
    desired_output_class = 3;
elseif window_shape == [-1, 1]
    desired_output_class = 4;
else
    desired_output_class = 0;
end

end
% =========================================================================
%% END