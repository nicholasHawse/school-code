function [win] = ruin(odds)
%one if gambler a does not go bankrupt
%   Detailed explanation goes here
probability = rand();

player_one_mon = 10;
player_two_mon = 1;

while(player_two_mon > 0 & player_one_mon > 0)

    if   probability < odds
         player_two_mon = player_two_mon - 1;
         player_one_mon = player_one_mon + 1;
    else
         player_two_mon = player_two_mon + 1;
         player_one_mon = player_one_mon - 1;
    end
end
if player_two_mon > 0
    win = 1;
else
    win = 0;
end