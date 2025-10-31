function [num_of_matches] = experement()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

deck1 = randperm(52);
deck2 = randperm(52);
counter = (deck1 == deck2);

num_of_matches = sum(counter);


    
end