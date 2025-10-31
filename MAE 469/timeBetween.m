function [time] = timeBetween(element,nu1,nu2,mu)
%This function finds the time between two true anomalys given the orbital
%elements

E = @(e,nu) acos((e+cosd(nu))/(1+e*cosd(nu)));

n = @(mu,a) sqrt(mu/(a^3));

M = @(E,e) E - e*sin(E);

E1 = E(element.e,nu1);
E2 = E(element.e,nu2);

meanMotion = n(mu,element.a);

M1 = M(E1,element.e);
M2 = M(E2,element.e);
time = (M2-M1)/meanMotion;

end