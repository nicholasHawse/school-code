function [rijk,vijk] = elements2rv(elements,mu)
%elements2rv this function converts a set of orbital elements to r and v
%   it takes orbital elements ad returns the r and v vectors in the ijk
%   coordinate system

p = (1-(elements.e)^2)*elements.a;

rpqwMag = p/(1+elements.e*cosd(elements.nu));

rpqw(1) = rpqwMag*cosd(elements.nu);
rpqw(2) = rpqwMag*sind(elements.nu);
rpqw(3) = 0;

vpqw(1) = sqrt(mu/p)*(-1*sind(elements.nu));
vpqw(2) = sqrt(mu/p)*(elements.e+cosd(elements.nu));
vpqw(3) = 0;



rTilda = [cosd(elements.bigOmega)*cosd(elements.omega)-sind(elements.bigOmega)*sind(elements.omega)*cosd(elements.i) -cosd(elements.bigOmega)*sind(elements.omega)-sind(elements.bigOmega)*cosd(elements.omega)*cosd(elements.i) sind(elements.bigOmega)*sind(elements.i);
          sind(elements.bigOmega)*cosd(elements.omega)+cosd(elements.bigOmega)*sind(elements.omega)*cosd(elements.i) -sind(elements.bigOmega)*sind(elements.omega)+cosd(elements.bigOmega)*cosd(elements.omega)*cosd(elements.i) -cosd(elements.bigOmega)*sind(elements.i);
          sind(elements.omega)*sind(elements.i) cosd(elements.omega)*sind(elements.i) cosd(elements.i)];

vijk = rTilda*vpqw';
rijk = rTilda*rpqw';

end