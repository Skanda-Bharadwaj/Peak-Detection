%  ------------------------------------------------------------------------
%  Peak Detection : Get Slope
%  ------------------------------------------------------------------------
%  
%  Finds the slope of the signal within the window using curve fitting.
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [slope] = pd_4cp_getSlope(window)

%% ==================== Find the slope of the window ======================
x = window;
n = length(window);

x = x(:);

len_50_percent = ceil((50/100)*n);

x_left = x(1:len_50_percent);
x_right = x(len_50_percent+1 : end);

x_left_slope = fit_window(x_left);
x_right_slope = fit_window(x_right);


if x_left_slope == -1 && x_right_slope == -1
    slope = -1;
elseif x_left_slope == 1 && x_right_slope == 1
    slope = 1;
else
    slope = 0;
end

    function [sub_slope] = fit_window(xx)
        yy = 1:length(xx);
        yy = yy(:);
        c = fit(yy, xx, 'poly1');
        if c.p1 > 0
            sub_slope = 1;
        else
            sub_slope = -1;
        end
    end
        
end
% =========================================================================
%% END


