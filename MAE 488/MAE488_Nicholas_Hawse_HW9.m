% MAE488_Nicholas_Hawse_HW8
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 9
% Nicholas Hawse
% 04/15/2025
% This code finds and plots solutions to the problems in HW 9

clear;
clc;
clf;
close all;

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 9, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% =============================================================================
% Problem 6 
% =============================================================================
% This code plots the step responce of the angular velocity
% 
% 

fprintf('=============================\n')
fprintf('Problem 6 \n')
fprintf('=============================\n')
fprintf('This code plots the step responce of the angular velocity of\n')
fprintf('the three differnt closed loop transfer functions\n')
fprintf('see the figure below\n\n\n\n\n')

kiprob6num1 = 160;
k2prob6num1 = 34; 
prob6sys = tf([kiprob6num1],[2 (2+k2prob6num1) kiprob6num1])
subplot(3,1,1)
step(prob6sys)
ylabel('angular Velocity (rad/s)')

kiprob6num2 = 400;
k2prob6num2 = 58; 
prob6sys = tf([kiprob6num2],[2 (2+k2prob6num2) kiprob6num2])
subplot(3,1,2)
step(prob6sys)
ylabel('angular Velocity (rad/s)')

kiprob6num3 = 1000;
k2prob6num3 = 118; 
prob6sys = tf([kiprob6num3],[2 (2+k2prob6num3) kiprob6num3])
figure(1)
subplot(3,1,3)
step(prob6sys)
ylabel('angular Velocity (rad/s)')

% =============================================================================
% Problem 8 
% =============================================================================
% This code plots the root locus of the control system
% 
% 

fprintf('=============================\n')
fprintf('Problem 8 \n')
fprintf('=============================\n')
fprintf('This code plots the root locus of the control system\n')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')
figure(2)
rlocus(1,[3 12 0]);

% =============================================================================
% Problem 10 
% =============================================================================
% This code plots the root locus of the control system
% 
% 

fprintf('=============================\n')
fprintf('Problem 10 \n')
fprintf('=============================\n')
fprintf('This code plots the root locus of the control system\n')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')
figure(3)
rlocus([5 30 40],[4 25 16])