% MAE488_Nicholas_Hawse_HW1
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 1
% Nicholas Hawse
% 1/20/2025
% This code finds and plots solutions to the problems in HW 1

clear
clc
clf
close all

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 1, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% =============================================================================
% Problem 2 
% =============================================================================
% find the solution to the ODE with a step input then plot the solution
% 
%
fprintf('=============================\n')
fprintf('Problem 1 Part b and c\n')
fprintf('=============================\n')
fprintf('This code finds the soulution to the ODE found in problem 1 \n')
fprintf('and also plots the found values and manual soution to the ODE.\n')
fprintf('see the figure below\n\n\n\n\n')


% this function produces a transfer function object from the ODE
sys = tf(18,[3 33 84]); 

% this function finds the solution to the ODE from the transfer function
[y,tOut] = step(sys,[0,5]);

% a time vector
t = 0:0.05:5;
% the manualy found solution in code form
manualSolution = 3/14 - 1/2*exp(-4*t) + 2/7*exp(-7*t);
% puts the plot in a subplot
subplot(2,1,1)
% plots the manual solution in green with dots
plot(manualSolution,t,'g','Marker','.')
% lables for the plot
xlabel('time t')
ylabel('function value f(t)')
title('MAE 488, Homework 3, Problem 1, Part c')

subplot(2,1,2)
% plots the matlab solution in red
plot(y,tOut,'r')
% lables for the plot
xlabel('time t')
ylabel('function value f(t)')
