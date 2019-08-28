%  ------------------------------------------------------------------------
%  Peak Detection : Main File
%  ------------------------------------------------------------------------
%  This project finds peaks instantaneously in sinusoidal signals using
%  neural nets trained using sequential learning algorithm. 
% 
%  In this script, 5 classes of the sinusoidal signal are created to train
%  the network. 
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================== Initialize ==================================
clear; close all; clc;

%% ========================== User Inputs =================================

window_length = 81;

%% ======================= Train Neural Network ===========================

[windowed_signals_zero,  ...
 windowed_signals_one,   ...
 windowed_signals_two,   ...
 windowed_signals_three, ...
 windowed_signals_four] = pd_4cp_classSegregation(window_length);
                                   
save('pd_4cp_windowed_signals.mat', ...
     'windowed_signals_zero',       ...
     'windowed_signals_one',        ...
     'windowed_signals_two',        ...
     'windowed_signals_three',      ...
     'windowed_signals_four');
 
% =========================================================================
%% END