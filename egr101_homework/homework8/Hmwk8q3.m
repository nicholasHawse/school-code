clear;clc;close all;

l1 = 5; % l1 value
l2 = 6; % l2 value
alph = 0:.01:180; % make the vector of all angles of alpha
bet = 0:.01:180; % make a vector of all angles of beta

theta = 180-(alph+bet); % find the third angle of the triangle

d = sqrt(l1.^2+l2.^2 - 2*l1*l2*cos(deg2rad(theta))); % use law of cos to fing lenght of d in vector
plot(alph,d) % plot it
xlabel('alpha [deg]') % lable the plot
ylabel('distance [units]')