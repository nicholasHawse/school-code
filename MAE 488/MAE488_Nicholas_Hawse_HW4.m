% MAE488_Nicholas_Hawse_HW4
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 4
% Nicholas Hawse
% 1/20/2025
% This code finds and plots solutions to the problems in HW 4

clear
clc
close all

fprintf('====================================================================\n')
fprintf('MAE 488, Homework # 4, Spring 2025\n')
fprintf('====================================================================\n')
fprintf('\n\n')

% ====================================================================
% Problem 3 
% ====================================================================
% Plot the transfer function step resopnce  as a function
% of time
%
fprintf('=============================\n')
fprintf('Problem 3 Part d\n')
fprintf('=============================\n')
fprintf('This code plots the transfer function x1 step resopnce\n')
fprintf('see the figure below\n\n\n\n\n')

sys1 = tf([1 0 100],[1 0 550 0 15000]);%creates the transfer function
figure(1)
stepplot(sys1,[0 10]);% finds and plots the responce to a unit step
xlabel('t');
ylabel('x (meters)');
title('MAE 488, Homework 4, Problem 3, Part d')


fprintf('=============================\n')
fprintf('Problem 2 Part h\n')
fprintf('=============================\n')
fprintf('This code plots the transfer function of x2 step resopnce\n')
fprintf('see the figure below\n\n\n\n\n')

sys2 = tf([100],[1 0 550 0 15000]); %creates the transfer function
figure(2)
stepplot(sys2,[0 10]);% finds and plots the responce to a unit step
xlabel('t');
ylabel('x (meters)');
title('MAE 488, Homework 4, Problem 3, Part e')



fprintf('=============================\n')
fprintf('Problem 2 Part h\n')
fprintf('=============================\n')
fprintf('This code plots the sum of the two transfer functions step resopnce\n ')
fprintf('see the figure below\n\n\n\n\n')

figure(3)
stepplot(sys1,sys2,[0 10]); % finds and plots the responce to a unit step of both systems
xlabel('t');
ylabel('x (meters)');
title('MAE 488, Homework 4, Problem 3, Part f')