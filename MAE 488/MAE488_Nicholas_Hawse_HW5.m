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
fprintf('MAE 488, Homework # 5, Spring 2025\n')
fprintf('====================================================================\n')
fprintf('\n\n')

% ====================================================================
% Problem 8 
% ====================================================================
% 
%
fprintf('=============================\n')
fprintf('Problem 8 Part a\n')
fprintf('=============================\n')
fprintf('This code plots the transfer function  of current and voltage resopnce\n')
fprintf('responce see the figure below\n\n\n\n\n')

%given vals
r1 = 10^3;
c1 = 2*10^(-6);
l1 = 2*10^(-3);

% numerator and denominatior for transfer fun
num1 = 1/(r1*l1*c1);
den1 = [1 1/(r1*c1) 1/(l1*c1)];

num2 = [1/l1 0];
den2 = [1 1/(r1*c1) 1/(l1*c1)];

%make the transfer funs
sys1 = tf(num1,den1);
sys2 = tf(num2,den2);

%make a time var
time1 = -0.00001:0.00001:4;
% build the two voltage imputs
input1 = zeros(length(time1),1);
input1 = input1+5;
input1(1) = 0;

input2 = sin(60*(2*pi).*time1)*4;

%find the responce to each voltage
responce1 = lsim(sys1,input1,time1);

responce2 = lsim(sys2,input2,time1);

figure(1)
%plot the combined responce
plot(time1,(responce2+responce1))
xlim([0 0.2])
ylabel('current (A)')
title('MAE 488, Homework 5, Problem 8')
xlabel('time (s)')




% ====================================================================
% Problem 9 
% ====================================================================
% 
%

fprintf('=============================\n')
fprintf('Problem 9 Part a\n')
fprintf('=============================\n')
fprintf('This code plots the transfer of the armature controled motor resopnce\n')
fprintf('see the figure below\n\n\n\n\n')

% motor parameters
kt = 0.05;
kb = kt;
c = 0;
ra = 0.8;
la = 0.003;
I = 0.00008;



% transfer function definitions
numerator1 = [I c];
numerator2 = kt;
denominator = [la*I (ra*I) (kb*kt)];

sysi = tf(numerator1,denominator);

sysOmega = tf(numerator2,denominator);

trap = trapmf(time1,[0 0.5 2 2.5]).*30;


i3 = lsim(sysi,trap,time1);

omega = lsim(sysOmega,trap,time1);
figure(2)
plot(time1,i3)
ylabel('current (A)')
title('MAE 488, Homework 5, Problem 9, Part a')
xlabel('time (s)')
xlim([0 4])
ylim([-2 2])

figure(3)
plot(time1,omega)
title('MAE 488, Homework 5, Problem 9, Part a')
t = '$\omega$ (Rad/s)';
ylabel(t,'interpreter','latex')
xlabel('time (s)')
xlim([0 4])
ylim([0 700])



fprintf('=============================\n')
fprintf('Problem 8 Part a\n')
fprintf('=============================\n')
fprintf('This code finds the motor performance paremeters\n\n')



currentvals = i3; 
currentint = currentvals.^2;


 

energyPerCycle = ra^2*rms(i3)*4.69; % calc for the energy
imax = max(i3); % maximum value
Tmax = kt*imax; % fomula
irms = rms(i3);
Trms = irms*kt;

fprintf('energy per cycle: %f J\n',energyPerCycle)
fprintf('max current: %f A\n',imax)
fprintf('max tourqe: %f N*m\n',Tmax)
fprintf('RMS current: %f A\n',irms)
fprintf('RMS tourqe: %f N*m\n',Trms)