function [outputArg1] = mprae(current,previous)
%Magnitude percent relitive error
%   
outputArg1 = (abs(current-previous)/current)*100;
end