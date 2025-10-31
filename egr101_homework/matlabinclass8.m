clear; clc; close all;

t = 0:.001:10;

vs = 3*(exp(-t/3)).*sin(pi*t);

cllipedV = vs>=0;

subplot(2,1,1);

plot(t,vs)

vbatt = vs;

vbatt((vbatt<0)) = 0;

subplot(2,1,2);
plot(t,vbatt);
