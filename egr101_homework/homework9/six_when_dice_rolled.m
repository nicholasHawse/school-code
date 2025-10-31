function [probability] = six_when_dice_rolled(num_of_dice)
%returns on if you get a six
%   Detailed explanation goes here
count = 0;

for i = 1:num_of_dice
    dice = randperm(6); 
    
    if dice(1) == 6
        count = count + 1;
    end
    if count >= ((num_of_dice+1)/6)
        probability = 1;
    else
        probability = 0;
    end
end