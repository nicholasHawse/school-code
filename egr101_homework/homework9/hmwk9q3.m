clc;clear;close all;


number_of_trials = 100000;
total = 0;

for i = 1:number_of_trials
    total = total + experement();
end

value = total/number_of_trials;

% average value is 0.996920000000000