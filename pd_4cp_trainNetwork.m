%  ------------------------------------------------------------------------
%  Peak Detection : Training
%  ------------------------------------------------------------------------
%  
%  A neural network is trained to classify a given signal into either of
%  the 4 defined classes. The network is trained using Sequential Learning
%  Algorithm.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================== Initialize ==================================

clear; close all; clc;

%% ======================= Load Training Database =========================

load ('pd_4cp_trainingData.mat');

%% ======================= Neural Network Model ===========================

window_size  = 81; 

input_layer  = window_size;
hidden_layer = 400;
output_layer = 5;

% ==================== Activation Field Parameters ========================

a = 1.7159;
b = 2/3;

% ================== Initializing Layer-1 Weights =========================

w1 = pd_4cp_random_weights(input_layer, hidden_layer);
w2 = zeros(output_layer, hidden_layer+1);

% ================== Initializing lambda and P ============================

lambda = 10^-6;
p = 1/lambda * eye(hidden_layer+1);

%% ============= Sequential Extreme Learning Algorithm ====================

random_num = randperm(size(X, 1));

for i = 1 : size(X, 1)
    
    yd = ((1 : output_layer) == y(random_num(i)))';  
    x = X(random_num(i), :);                             
    x1 = [1, x]'; 
    v1 = w1 * x1;    
    y1 = a * tanh(b * v1);
    x2 = [1; y1];   
    p  = p - (p * (x2 * x2') * p) ./ (1 + (x2' * p * x2)); 
    w2 = w2 + ((yd - (w2 * x2)) * (x2' * p));
    iteration = i  
    
end

save('pd_4cp_weights.mat', 'w1', 'w2');

% =========================================================================
%%  END