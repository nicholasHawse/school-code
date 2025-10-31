function [elements] = rv2elements(r,v,mu)
%rv2elements this function finds the orbital elements
%   the r and v vectors must be in the ijk coordinate system

mag = @(vector) sqrt(vector(1)^2 + vector(2)^2 + vector(3)^2);
h = cross(r,v);
n = cross([0 0 1],h);
e = 1/mu.*((mag(v)^2-1/mag(r))*r - (dot(r,v))*v);
elements.a = 1;

elements.e = mag(e);

elements.i = acosd(h(3)/mag(h));

if n(2) > 0
    elements.bigOmega = acosd(n(1)/mag(n));
else
    elements.bigOmega = 360 - acosd(n(1)/mag(n));
end
if e(3) > 0
    elements.omega = acosd(dot(n,e)/(mag(n)*mag(e)));
else
    elements.omega = 360 - acosd(dot(n,e)/(mag(n)*mag(e)));
end
if dot(r,v) > 0
    elements.nu = acosd(dot(e,r)/(mag(e)*mag(r)));
else
    elements.nu = 360 - acosd(dot(e,r)/(mag(e)*mag(r)));
end
if r(3) > 0
    elements.u = acosd(dot(n,r)/(mag(n)*mag(r)));
else
    elements.u = 360 - acosd(dot(n,r)/(mag(n)*mag(r)));
end

p = mag(h)^2/mu;

elements.a = p/(1-(elements.e)^2);



end