clc;clear;close all;

number_dice = 6:6:72; % number of dice rolled

number_of_trials = 100000; % number of trials
 
for m = number_dice % roll each set of dice 
    six_dice = 0;

    for d = 1:number_of_trials % roll the number of trials dice
        six_dice = six_dice + six_when_dice_rolled(m); % count up istances of geting a six or equivelent
    end
    six_dice = six_dice/number_of_trials; % take the mean 

    plot(m,1-six_dice,'o') % plot them on the graph with a marker
    hold on

end

xlabel('number of dice rolled') % lable the graph
ylabel('probability')
title('dice vs six probability')
