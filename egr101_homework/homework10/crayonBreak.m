function [small,medium,large] = crayonBreak()
%breaks a crayon in two places and then outputs the size of the pieces from
%smallest to largest
crayon = 1;

size = 1:3;

breakB(1) = rand(); % generate tow random breaks 
breakB(2) = rand();

breakB = sort(breakB); % figure out the order of the breaks so that the second dosent end up messing with the math

size(1) = breakB(1); % calculate the size of  the pieces from left to right 
size(2) = breakB(2)-breakB(1);
size(3) = crayon-breakB(2);

size = sort(size); % sort the pieces by size

small = size(1); % return the pieces in order of size
medium = size(2);
large = size(3);