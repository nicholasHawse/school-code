clear; clc;
l = (.001:.001:2000);

a = 4000;

r = -2.*l/pi + 2./pi*sqrt(l.^2+(a.*pi/2));

plot(l,r)

xlabel('radius')
ylabel('length')
title('radius vs lenght keeping area = 4000')

cost = (60.*pi.*r) + 20*((2.*r)+(2.*l));

[mincost,idx] = min(cost)

% mincost = 7941.4 idx = 83443