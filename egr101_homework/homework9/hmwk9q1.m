clear;clc;close all; % startup stuff

num_trials = 10000; % number of trials 
num_deaths = 0;  % initilise the varible that counts the number of deaths

for i = 0:num_trials % run loop the number of trials times

    num_deaths = num_deaths + duel(); % count up the number of deaths in 1000000 trials
end

probibility = num_deaths/num_trials; % devide number of deaths by number of trials to get mean

% porobability of about 8.3%

