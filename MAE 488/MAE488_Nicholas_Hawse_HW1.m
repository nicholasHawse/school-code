% MAE488_Nicholas_Hawse_HW1
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 1
% Nicholas Hawse
% 1/20/2025
% This code finds and plots solutions to the problems in HW 1

clear
clc
close all

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 1, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% =============================================================================
% Problem 2 
% =============================================================================
% Plot the function y(x) and its first and second derivitives as a function
% of time
%
fprintf('=============================\n')
fprintf('Problem 2 Part h\n')
fprintf('=============================\n')
fprintf('This code plots the function of displacement Y(x) = A sin( Bt + PHI) and\n')
fprintf('also plots the velocity function and acceleration function coresponding\n')
fprintf('to the displacement function.\n')
fprintf('see the figure below\n\n\n\n\n')

% Y(t) = A sin( Bt + PHI)

A = 4; % 4 ft amplitude
B = pi/2; % radian frequency 
PHI = 1/2; % phase offset rad
time = 0:0.001:10; % a vector that discatizes time

YOfT = @(t) A*sin(B*t + PHI); % the function of displacement
VOfT = @(t) B*A*cos(B*t + PHI); % the function of velocity
AOfT = @(t) -B*B*A*cos(B*t + PHI); % the function of acc.


subplot(3,1,1) % puts a plot in the first of 3 subplots
y1 = YOfT(time); % finds the function output as a vector
plot(time,y1,'r') %plots the function in red
xlabel('time [s]') % lables
ylabel('Displacement [ft]')

title('MAE 488, Homework 1, Problem 2, Part h') %title

subplot(3,1,2)% puts a plot in the 2 of 3 subplots
y2 = VOfT(time);% finds the function output as a vector
plot(time,y2,'g--')%plots the function in green dashes
xlabel('time [s]')
ylabel('Velocity [ft/s]')

subplot(3,1,3)% puts a plot in the 3 of 3 subplots
y3 = AOfT(time);% finds the function output as a vector
plot(time,y3,'b:')%plots the function in blue dots
xlabel('time [s]')
ylabel('Acceleration [ft/s^2]')

% =============================================================================
% Problem 3 
% =============================================================================
% Plot the function y(x) two of its talor approximations 
%
fprintf('=============================\n')
fprintf('Problem 3 Part d\n')
fprintf('=============================\n')
fprintf('This code plots the function f(x) = sqrt(x)*sin(x) and also two of its\n')
fprintf('first order taylor series aproximations at x = 2 and x = 6.36 in radiens\n')
fprintf('see the figure below\n\n\n\n\n')

% f(x) = sqrt(x)cos(x)
% f'(x) = -sqrt(x)sin(x) + 1/2*1/sqrt(x)*cos(x)

FOfX = @(x) sqrt(x).*cos(x); % the function of x

FPrimeOfX = @(x) -sqrt(x)*sin(x) + 0.5*x^(-0.5)*cos(x); %the derivative

TaylorOne = @(x) FPrimeOfX(2)*x +(FOfX(2)-2*FPrimeOfX(2)); % the first order taylor at a = 2

TaylorTwo = @(x) FPrimeOfX(6.36)*x +(FOfX(6.36)-6.36*FPrimeOfX(6.36));% the first order taylor at a = 6.36

figure(2) % start a new figure

fplot(FOfX,[0,8],'b') % plot the origanal function
hold on;
fplot(TaylorOne,[1,3],'m') % plot the first talor aprox at a = 2

plot(2,FOfX(2),'r*') % plot the point that the taylor comes from

fplot(TaylorTwo,[5.36,7.36],'c')% plot the first talor aprox at a = 6.36

plot(6.36,FOfX(6.36),'b*')% plot the point that the taylor comes from

title('MAE 488, Homework 1, Problem 3, Part d') %lables
xlabel('x')
ylabel('f(x)')
ylim([-2.2,3])
legend('f(x) = sqrt(x)*cos(x)','Linearized f(x) at x = 2'...
    ,'The Point (2,1.41)','Linearized f(x) at x = 6.36' ...
    ,'The Point (6.36,2.5)','Location','northwest')


% =============================================================================
% Problem 4 part a \n
% =============================================================================
% Plot a table on linear exponetial and power axies to see where it is linear 
%

fprintf('=============================\n')
fprintf('Problem 4 Part a \n')
fprintf('=============================\n')
fprintf('This code plots a set of data on three plots: Linear, LogY and Log-Log\n')
fprintf('Given:\n')
fprintf('x= 10 14.2 18.4 22.6 26.8 31 35.2\n')
fprintf('y= 10 22.6 35.2 47.8 60.4 73 85.6\n')
fprintf('see the figure below\n\n\n\n\n')

ax = [10 14.2 18.4 22.6 26.8 31 35.2];
ay = [10 22.6 35.2 47.8 60.4 73 85.6];



figure(3) % creates a new figure 

subplot(3,1,1) % first of 3 subplots
plot(ax,ay)
title('MAE 488, Homework 1, Problem 4, Part a')
ylabel('y linear')

subplot(3,1,2) % first of 3 subplots
semilogy(ax,ay)
ylabel('y exponential')

subplot(3,1,3) % first of 3 subplots
loglog(ax,ay)
ylabel('y power')
xlabel('x')




% =============================================================================
% Problem 4 part b
% =============================================================================
% Plot a table on linear exponetial and power axies to see where it is linear 
%

fprintf('=============================\n')
fprintf('Problem 4 Part b\n')
fprintf('=============================\n')
fprintf('This code plots a set of data on three plots: Linear, LogY and Log-Log\n')
fprintf('Given:\n')
fprintf('x= 1     1.5    2     2.5   3     3.5    4\n')
fprintf('y= 1.218 4.252 14.84 51.8 180.8 631.1 2202.7\n')
fprintf('see the figure below\n\n\n\n\n')



bx = [1 1.5 2 2.5 3 3.5 4];
by = [1.218 4.252 14.84 51.8 180.8 631.1 2202.7];

figure(4)

subplot(3,1,1) % second of 3 subplots
plot(bx,by)
title('MAE 488, Homework 1, Problem 4, Part b')
ylabel('y linear')

subplot(3,1,2) % second of 3 subplots
semilogy(bx,by)
ylabel('y exponential')

subplot(3,1,3) % second of 3 subplots
loglog(bx,by)
ylabel('y power')
xlabel('x')


% =============================================================================
% Problem 4 part c
% =============================================================================
% Plot a table on linear exponetial and power axies to see where it is linear 
%

fprintf('=============================\n')
fprintf('Problem 4 Part c\n')
fprintf('=============================\n')
fprintf('This code plots a set of data on three plots: Linear, LogY and Log-Log\n')
fprintf('Given:\n')
fprintf('x= 2     5    8    11    14     17  20\n')
fprintf('y= 0.032 1.25 8.19 29.28 76.83 167 320\n')
fprintf('see the figure below\n\n\n\n\n')


cx = [2 5 8 11 14 17 20];
cy = [0.032 1.25 8.19 29.28 76.83 167 320];

figure(5)

subplot(3,1,1) % second of 3 subplots
plot(cx,cy)
title('MAE 488, Homework 1, Problem 4, Part c')
ylabel('y linear')

subplot(3,1,2) % second of 3 subplots
semilogy(cx,cy)
ylabel('y exponential')

subplot(3,1,3) % second of 3 subplots
loglog(cx,cy)
ylabel('y power')
xlabel('x')