%  ------------------------------------------------------------------------
%  Peak Detection : Create the data to train the Neural Network
%  ------------------------------------------------------------------------
%  
%  This script assigns a label to every windowed signal creating an ordered
%  pair of training data and label. 
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================== Initialize ==================================

clear; close all; clc;

%% ======================= Load Windowed Signals ==========================

load('pd_4cp_windowed_signals.mat');


%% ========================= Initializations ==============================

n = 35921; l = 81;

window_for_classZero  = randperm(size(windowed_signals_zero,  1));
window_for_classOne   = randperm(size(windowed_signals_one,   1));
window_for_classTwo   = randperm(size(windowed_signals_two,   1));
window_for_classThree = randperm(size(windowed_signals_three, 1));
window_for_classFour  = randperm(size(windowed_signals_four,  1));

classZero  = zeros(n, l);
classOne   = zeros(n, l);
classTwo   = zeros(n, l);
classThree = zeros(n, l);
classFour  = zeros(n, l);

%% ==================== Windowed Signal Seggregation ======================

for i = 1:n
    
    c0 = window_for_classZero(i);
    classZero(i, :)  = windowed_signals_zero(c0, :);
    
    c1 = window_for_classOne(i);
    classOne(i, :)   = windowed_signals_one(c1, :);
    
    c2 = window_for_classTwo(i);
    classTwo(i, :)   = windowed_signals_two(c2, :);
    
    c3 = window_for_classThree(i);
    classThree(i, :) = windowed_signals_three(c3, :);
    
    c4 = window_for_classFour(i);
    classFour(i, :)  = windowed_signals_four(c4, :);
    
    iteration = i
    
end

%% ======================= Final Data Creation ============================

X = [classOne;   ...
     classTwo;   ...
     classThree; ...
     classFour;  
     classZero];
 
y = [1*ones(n, 1); ...
     2*ones(n, 1); ...
     3*ones(n, 1); ...
     4*ones(n, 1); ...
     5*ones(n, 1)];

%% ============================= Save =====================================
 
save('pd_4cp_trainingData.mat','X','y');

% =========================================================================
%% END