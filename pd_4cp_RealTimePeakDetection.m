%  ------------------------------------------------------------------------
%  Peak Detection : Real Time Peak Deetection 
%  ------------------------------------------------------------------------
%  
%  Window of pre-defined is sent through the signal. The part of the signal
%  that is inside the window is sent into the neural network for
%  classification. If the classifed signal belongs to class-2, then it is
%  further sent for peak-finding. It is made sure that peak is detected
%  only once as the window propagates thourgh the same trough of the
%  signal.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================== Initialize ==================================
clear; close all; clc;

%% ====================== Load Testing Database ===========================

load ('ppg_data_raw.mat');
load ('pd_4cp_weights.mat');

% ========================= Network Parameters ============================

window_length = 81;

a = 1.7159;
b = 2/3;

% ====================== Neural Network Prediction ========================

for i = 1:1 %length(X_train)

signal = X_train{13, 1};
y = 1:length(signal);
nn_signal = [zeros(window_length-1, 1); ... 
             signal; ...
             zeros(window_length-1, 1)];
signal_length = length(nn_signal);

norm_signal = (nn_signal-mean(nn_signal))/max(nn_signal);

figure
plot(y, norm_signal(window_length : end-window_length+1)); hold on

doc = [];
no_of_peaks = 0; peak = 0; pos = 0; cnt = 0;
for j = 1 : (window_length - 1 + length(signal))
    
    x = norm_signal(j : (j + window_length - 1))';
    m = size(x, 1);
    h1 = a * tanh(b * ([ones(m, 1) x] * w1'));
    h2 = ([ones(m, 1) h1] * w2');
    [dummy, desired_class] = max(h2, [], 2);
    doc = [doc; desired_class];
    
    if desired_class == 2
        
        ck_sig = x;
        window_central_pos = ck_sig(ceil(window_length/2));
        window_left = ck_sig(1:floor(window_length/2));
        window_right = ck_sig(ceil(window_length/2)+1:end);
        
        if((window_central_pos > max(window_left)               && ...
            window_central_pos > max(window_right))             || ...
           (window_central_pos == window_left(end)              && ...
           any(window_central_pos > window_left(1:end-1)))      || ...
           (window_central_pos == window_right(1)               && ...
           any(window_central_pos > window_left(2:end))))
       
            old_peak = peak;
            old_pos  = pos; 
            
            no_of_peaks = no_of_peaks + 1;
            if (j > window_length-1)
                
                peak = x(ceil(window_length/2));
                pos = j-(window_length/2);
                peaks(no_of_peaks, 1) = peak;
                peaks(no_of_peaks, 2) = pos;
                if (pos - old_pos < 100)
                    peak = old_peak;
                    pos = old_pos;
                    no_of_peaks = no_of_peaks - 1;
                else
                    cnt = cnt+1;
                    peaks(cnt, 1) = peak;
                    peaks(cnt, 2) = pos;
                   scatter(pos, peak);
                end
                
            end
            
        end
        
    end     
    
end
figure
findpeaks(signal, 'MINPEAKDISTANCE', 90);
[t1, t2] = findpeaks(signal, 'MINPEAKDISTANCE', 140);
peaks_list(i, :) = [cnt, length(t1), (cnt/length(t1))*100];
iter = i
end

average_accuracy = mean(peaks_list(:, 3))

% =========================================================================
%% END