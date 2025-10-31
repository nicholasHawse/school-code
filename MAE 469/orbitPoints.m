function [x,y,z] = orbitPoints(elements,nuRange)
%given a set of orbital elements and a true anomaly range this function 
% returns points on the orbit 
%   

% orbit of first
x = zeros(100,1);
y = zeros(100,1);
z = zeros(100,1);

for i = 1:1:360
    stepSize = (nuRange(2)-nuRange(1))/360;
    elements.nu = stepSize*(i-1)+nuRange(1);
    [rtemp,~] = elements2rv(elements,1);
    x(i) = rtemp(1);
    y(i) = rtemp(2);
    z(i) = rtemp(3);
end

end