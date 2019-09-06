%  ------------------------------------------------------------------------
%  Peaks Detection : Raw data creation
%  -------------------------------------------------------------------------
%  
%  This data was taken from the publicly availble Capnobase IEEE TBME 
%  Respiratory Rate Benchmark data set. This script helps to collect data 
%  into one variable in the required format. 
%  
%  This data is avaialble in 
%  "http://www.capnobase.org/database/pulse-oximeter-ieee-tbme-benchmark/"
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
folder_path = '../TBME2013-PPGRR-Benchmark_R3/data';

folder = dir(folder_path);
X_train = {}; cnt = 0;
for i = 3:length(folder)
    load(fullfile(folder_path, folder(i).name));
    cnt = cnt+1;
    X_train{cnt, i} = signal.pleth.y(50001:60000, i); 
end

% =========================================================================
%% End