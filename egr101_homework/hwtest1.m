clear;clc;

l = (.001:.001:900);

R = -(2*l/pi) + (2/pi)*(sqrt(l.^2+((4000*pi)/2)));

plot(R,l)