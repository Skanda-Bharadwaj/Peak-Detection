%  ------------------------------------------------------------------------
%  Peak Detection : Predict the shape
%  ------------------------------------------------------------------------
%  
%  Given a trained network, this scripts tests the network's accuracy based 
%  on the test data creates a confusion matrix.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================== Initialize ==================================
clear; close all; clc;

%% ========================== Prediction ==================================
                                                            
load ('pd_4cp_trainingData.mat')
load ('pd_4cp_weights.mat');
 
o = zeros(10, 3);
r = randperm(size(X, 1));
n = size(X, 1);

a = 1.7159;
b = 2/3;

%% ====================== Feed-Forward Netwrok ============================

for i = 1:n
    
    x = X(r(i), :);
    m = size(x, 1);
    h1 = a * tanh(b * ([ones(m, 1) x] * w1'));
    h2 = ([ones(m, 1) h1] * w2');
    [d, predicted_output] = max(h2);  
    o(i, :) = [y(r(i)) predicted_output y(r(i)) == predicted_output];
    iter_i = i
    
end
Accuracy_1 = mean(o(:, 3))*100


peak_window = [];
window = [];
for j = 1:n
    
    if o(j, 1) == 2
        
        window = [window; j];
        peak_window = [peak_window; o(j, :)];
        
    end
    iter_j = j
    
end
peak_window;
Accuracy_2 = mean(peak_window(:, 3))*100;

targets = zeros(size(w2, 1), size(o, 1));
outputs = zeros(size(w2, 1), size(o, 1));

for ii = 1:size(w2, 1)
    for jj = 1:size(o, 1)
        if (o(jj, 1) == ii)
            targets(ii, jj) = 1;
        else
            targets(ii, jj) = 0;
        end
    end
end

for iii = 1:size(w2, 1)
    for jjj = 1:size(o, 1)
        if (o(jjj, 2) == iii)
            outputs(iii, jjj) = 1;
        else
            outputs(iii, jjj) = 0;
        end
    end
end

plotconfusion(targets, outputs, 'PDPP');
set(findall(0,'FontName','Helvetica','FontSize',10),...
    'FontName','Times New Roman','FontSize',12);
    
% ========================================================================
%% END