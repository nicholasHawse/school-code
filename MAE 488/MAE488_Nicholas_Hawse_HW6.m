% MAE488_Nicholas_Hawse_HW6
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 6
% Nicholas Hawse
% 03/15/2025
% This code finds and plots solutions to the problems in HW 6

clear;
clc;
clf;
close all;

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 1, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% =============================================================================
% Problem 8 
% =============================================================================
% find the numerical solutions to the ode given below and the responce to
% the input f(t)
% 
% dy/dt + 2y = f(t)
% y(0) = 0
fprintf('=============================\n')
fprintf('Problem 8 \n')
fprintf('=============================\n')
fprintf('This code finds the numerical solutions to the ode given ')
fprintf('below and the responce to the input f(t)\n')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')

function fval = fot(t) % input function f(t)
    if (t >= 0) && (t <= 2) 
        fval = 3*t;

    elseif (t > 2) && (t < 5)
        fval = 6;
    
    elseif (t >= 5) && (t <= 7)
        fval = -3*(t-5)+6;
    else
        fval = 0;
    end
end


y0 = 0; % initial conditions

dydt = @(time,y) fot(time) - 2*y; % defines the ode

[t,y] = ode45(dydt,[0 7],y0); % solves the ode

figure(1)

plot(t,y) %plots the ode
title('MAE 488, Homework 6, Problem 8')
xlabel('time (s)')
ylabel('magnitude')


% =============================================================================
% Problem 9 
% =============================================================================
% find the solutions to the ssm given below and the responce to
% the input u
% 
% 
% 
fprintf('=============================\n')
fprintf('Problem 9 \n')
fprintf('=============================\n')
fprintf('This code finds the responces of the state space model to the')
fprintf('input of the function u(t)')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')

A9 = [-7 4; 0 -3];
B9 = [0; 8];
C9 = [1 0; 0 1];
D9 = [0; 0];

t = 0:0.001:10;

uot = [t; 3*sin(2*t)]';

out1 = sim('mdl548');

time = out1.tout;
val1 = out1.out548;

plot(time,val1)
title('MAE 488, Homework 6, Problem 9')
xlabel('time (s)')
ylabel('magnitude')
legend('X1','X2')


% =============================================================================
% Problem 10 
% =============================================================================
% find the solutions to the ssm of the spring mass system and the 
% responce to the input of a force f(t)
% 
% 
fprintf('=============================\n')
fprintf('Problem 10 \n')
fprintf('=============================\n')
fprintf('find the solutions to the ssm of the spring mass system and the')
fprintf('responce to the input of a force f(t)')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')

% the matricies that define the ss model
A10 = [0 0 1 0; 0 0 0 1; -5 4 -4 1; 4 -4 1 -1];
B10 = [0; 0; 0; 1];
C10 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
D10 = [0; 0; 0; 0];


% creates the sections of the piecewise function
t1 = 0:0.0001:(1-0.0001);
t2 = 1:0.0001:(2-0.0001);
t3 = 2:0.0001:10;

t = [t1 t2 t3];

% creates the function values of the piecewise fun
fot1 = t1;
fot2 = 2 - t2;
fot3 = t3./t3.*0; 

fot10 = [fot1 fot2 fot3];% composes the parts of the piecewises fun

fot10 = [t; fot10]'; % creates the input for the sim

out2 = sim('mdl560'); % runs the simulation

time = out2.tout; % gets the time out of the simulink
val2 = out2.out560; % gets the array of the outputs of the ss model

figure(3) % new figure

plot(time,val2) % plots the values of the outputs of the ss model
title('MAE 488, Homework 6, Problem 10')
xlabel('time (s)')
ylabel('magnitude')
legend('X1', 'X2', 'dX1/dt', 'dX2/dt')






