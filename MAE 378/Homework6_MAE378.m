
clf;
close;
clear;
clc;



% t = 0

x0 = [-3 0 3];
t0 = [25 660 25];
x = -3:0.01:3;
p = polyfit(x0,t0,2)
y0 = polyval(p,x);

figure
plot(x0,t0,'o')
hold on
plot(x,y0,'Color','b')
xlabel('distance (cm)')
ylabel('Temperature (C)')
title('Time 10')
hold off



% t = 5

% t = 10

