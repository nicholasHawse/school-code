clc; clear; close all;

odds_vector  = 0:.1:1; % a vector of all different odds

number_of_trials = 1000000; % number of trials

count_of_total = 0; % counter var for probability

trial_storage = 0:10; % holding var for ploting

for i = odds_vector % runs the loop for each odds

    increment = (10*i)+1; % a increment of the trial storage

    count_of_total = 0;


    for m = 0:number_of_trials % runs the number of trials times
        count_of_total = count_of_total + ruin(i); % counts the number of bankrupsys
    end
    trial_storage(increment) = count_of_total/number_of_trials; % takes the average of the number of bankrupsys
    
end
plot(odds_vector,trial_storage) %plots the data
hold on
plot(odds_vector,1-trial_storage)
