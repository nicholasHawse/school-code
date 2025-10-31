% MAE488_Nicholas_Hawse_HW8
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 8
% Nicholas Hawse
% 03/15/2025
% This code finds and plots solutions to the problems in HW 8

clear;
clc;
clf;
close all;

fprintf('===================================================================\n')
fprintf('MAE 488, Homework # 8, Spring 2025\n')
fprintf('===================================================================\n')
fprintf('\n\n')

% =============================================================================
% Problem 3 
% =============================================================================
% This code pots the magitude and phase with respect to frequency
% 
% 

fprintf('=============================\n')
fprintf('Problem 3 \n')
fprintf('=============================\n')
fprintf('This code plots phase and manitude with respect to frequency\n')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')

w = linspace(0.01,1000,10000);

magnitude = 20.*log10(1./sqrt(w.^4 + 20.*w.^2 + 64));

phi = rad2deg(-atan(w./2)-atan(w./4));

figure(1)
subplot(2,1,1);
semilogx(w,magnitude)
ylabel('Magnitude (dB)')
title('MAE 488, Homework 8, Problem 3')
ylim([-120 0])

subplot(2,1,2);
semilogx(w,phi)
xlabel('\omega (Rad/s)')
ylabel('\phi (Deg)')
% =============================================================================
% Problem 5 
% =============================================================================
% This code pots the magitude and phase with respect to frequency
% 
% 
fprintf('=============================\n')
fprintf('Problem 5 \n')
fprintf('=============================\n')
fprintf('This code finds the bode plot of a transfer function\n')
fprintf('\n')
fprintf('see the figure below\n\n\n\n\n')

sys1 = tf(1000000,[1 200 20000 1000000]);
figure(2)
bode(sys1)
title('MAE 488, Homework 8, Problem 5')
grid on;
B = bandwidth(sys1); % finds bandwidth
fprintf('the bandwidth is %f',B)



