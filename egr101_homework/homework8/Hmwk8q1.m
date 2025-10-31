clear; clc; close all; %startup procedures

t = 0:.001:10; % make time vector with incements of 1 millisecond

x = 4*t.^2; % equation for x(t)
y = 25-2*t; % equation for y(t)
xlabel('t [s]')
ylabel('x,y')


plot(t,x)
hold on
plot(t,y)

first_t_x = t(x>45);%3.3550 6646 instances 10-3.3550 time left
first_t_y = t(y<5); % dosent happen 0 instances and no time left
second_t_x = t(x>55);% 3.7090 - 10 sec
second_t_y = t(y>4.2);% 0 - 10 sec




