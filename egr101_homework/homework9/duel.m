function [duel_result] = duel()
% simulation of a duel
%   in five minite increments
firstArival = randi(12) % first arrival as a factor of five min
secondArival = randi(12) % second arrival as a factor of five min

if firstArival == secondArival
    duel_result = 1;
else
    duel_result = 0;
end

end