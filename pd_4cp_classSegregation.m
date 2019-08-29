%  ------------------------------------------------------------------------
%  Peak Detection : pd_4cp_classSegregation
%  ------------------------------------------------------------------------
%  
%  This function seggregates the sinusoidal signal into the respective 
%  classes.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [windowed_signals_zero,  ...
          windowed_signals_one,   ...
          windowed_signals_two,   ...
          windowed_signals_three, ...
          windowed_signals_four] = pd_4cp_classSegregation(window_length)
      
%% ====================== Load Training Database ==========================

load ('ppg_data_raw.mat');

%% ====================== Creation of classes  ============================

classes = []; windowed_signals = [];
for i = 1:size(X_train, 1)
    
    signal = [zeros(window_length-1, 1); ... 
              X_train{i, 1}; ...
              zeros(window_length-1, 1)];        
    norm_signal = (signal-mean(signal))/max(signal);
    
    for j = 1:(window_length - 1 + length(X_train{i, 1}))
        
        nn_signal_window = norm_signal(j : j+window_length-1);
        y = pd_4cp_findClass(nn_signal_window);
        windowed_signals = [windowed_signals; nn_signal_window'];
        classes = [classes; y];
     
    itertaion_number = [i, j]                         
    end
    
end

windowed_signals_zero = [];
windowed_signals_one = [];
windowed_signals_two = [];
windowed_signals_three = [];
windowed_signals_four = [];

for k = 1:length(classes)
      j = classes(k);
            switch j
                case 1,
                    windowed_signals_one = [windowed_signals_one; ...
                                            windowed_signals(k, :)];
                case 2,
                    windowed_signals_two = [windowed_signals_two; ...
                                            windowed_signals(k, :)];
                case 3,
                    windowed_signals_three = [windowed_signals_three; ...
                                              windowed_signals(k, :)];
                case 4,
                    windowed_signals_four = [windowed_signals_four; ...
                                             windowed_signals(k, :)];
                otherwise,
                    windowed_signals_zero = [windowed_signals_zero; ...
                                             windowed_signals(k, :)];
            end
            iteration = k
            
end
        
end
% =========================================================================
%% END                                               