% MAE488_Nicholas_Hawse_HW1
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 10
% Nicholas Hawse
% 04/20/2025
% This code finds and plots solutions to the problems in HW 10

clear
clc
close all

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 10, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% magnitude of the step disturbance
T_d = 0.1;
% max step size of the simulation
max_step_size = 0.001;
% stop time of the simulation
stop_time = 5;

% given values 
L = 2e-3;
R = 0.6;
K_T = 0.04;
c = 0;
I = 6e-5;

% calculated values of the gains
K_I = 0.096;
K3 = -0.476;
K2 = 0.00516;
K1 = 0.0576;

% upper and lower saturation limits
satUpper = 20;
satLower = -20;
% magnitude of the command imput
InputCommand = 0;
% run the simulation
out = sim('HW10_488.slx');
% outputs of the simulation
td = out.tdout;
inputAngle = out.inout;
angle = out.theta;
current = out.CurentOut;
torque = out.torqueOut;

figure(1)
% plot of the input output and disturbance to the system
plot(angle)
hold on
plot(inputAngle,'Color','black','Linestyle',':')
plot(td,'Color','red')
legend('output angle','Input angle','Disturbance')
title('MAE 488, Homework 6, Problem 9')
xlabel('time (s)')
ylabel('magnitude')
axis([0 stop_time -7 2]);
title('Figure 1: HW10, Problem 1, part b')
ylabel('Input/Output Angle [rad] & Disturbance [N-m]')

figure(2)
% plot of the system current
plot(current)
axis([0 stop_time 0 3.5]);
title('HW9, Problem 1, part b')
ylabel('Current [Amp]')

figure(3)
% plot of the system torque
plot(torque)
axis([0 stop_time -0.1 0.05]);
title('HW9, Problem 1, part b')
ylabel('Torque [N-m]')


%part c

%upper and lower saturation limits
satUpper = 2;
satLower = -2;
% the command input step magnitude
InputCommand = 1;
% the torque disturbance step magnitude
T_d = 0.1;

% run the simulation
out = sim('HW10_488.slx');
% outputs of the sim
td = out.tdout;
inputAngle = out.inout;
angle = out.theta;
current = out.CurentOut;
torque = out.torqueOut;


figure(4)
% plot of the input output and disturbance to the system
plot(angle)
hold on
plot(inputAngle,'Color','black','Linestyle',':')
plot(td,'Color','red')
legend('output angle','Input angle','Disturbance')
title('MAE 488, Homework 6, Problem 9')
xlabel('time (s)')
ylabel('magnitude')
title('Figure 2: HW10, Problem 1, part c')
ylabel('Input/Output Angle [rad] & Disturbance [N-m]')

figure(5)
% plot of the system current
plot(current)
axis([0 stop_time 0 3.5]);
title('HW9, Problem 1, part c')
ylabel('Current [Amp]')

figure(6)
% plot of the system torque
plot(torque)
axis([0 stop_time -0.1 0.05]);
title('HW9, Problem 1, part c')
ylabel('Torque [N-m]')
