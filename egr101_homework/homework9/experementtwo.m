function [number] = experementtwo()
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

deck1 = [randperm(13),randperm(13),randperm(13),randperm(13)];
deck2 = [randperm(13),randperm(13),randperm(13),randperm(13)];
counter = (deck1 == deck2);

number = sum(counter);
end