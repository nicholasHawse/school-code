clc;clear;close all; % startup things


number_of_trials = 100000; % set the number of trials
total = 0; % creates the total var

for i = 1:number_of_trials % runs a loop the number of trials long
    total = total + experementtwo(); % adds up all of the experements
end

value = total/number_of_trials; % takes the average of the trials
% the value is 4.008900000000000