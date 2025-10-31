clear;clc;close all; % setup stuff

x = -5:0.1:5; % makes x vector of required size
y = x; % makes y vector of required size
[X,Y] = meshgrid(x); % makes x,y matrix

% makes z matrix for each plot
z1 = X.^3-3.*X.*Y.^2; 
z2 = X.^2+y.^2; 
z3 = X+Y;
z4 = X- 4.*Y;
z5 = sin(X)+cos(Y);




% makes the surface graphs
figure(1) 
surf(X,Y,z1) 
figure(2) 
surf(X,Y,z2)
figure(3) 
surf(X,Y,z3)
figure(4) 
surf(X,Y,z4)
figure(5) 
surf(X,Y,z5)



