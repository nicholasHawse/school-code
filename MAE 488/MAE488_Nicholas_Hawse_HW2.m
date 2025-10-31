% MAE488_Nicholas_Hawse_HW1
% MAE 488 03 Analisis of ANALY ENGINEERING SYSTEMS
% Homework 2
% Nicholas Hawse
% 1/26/2025

% This code checks the hand calculated partial fraction decompositions 
% of the homework questions useing the residual function.


% =============================================================================
% Problem 2 
% =============================================================================
% In this problem you find the patial fraction expasion of several
% functions then take the inverse lapace transform of each function. 
% this code calculates the roots of the denomenator function and 
% calculates the coefficents of the partial fraction expasion.
%
clc;clear;close

%problem 2 part a 
fprintf('=============================\n')
fprintf('Problem 5 \n')
fprintf('=============================\n')
fprintf('This code determines the coefficents on the partial fraction\n')
fprintf(['decomposition of the laplace transform functions useing' ...
    ' the \nresidual function built into matlab\n'])

fprintf('=============================\n')
fprintf('Problem 5 Part a\n')
fprintf('=============================\n')

% 

partATopFun = 32; % the coefficent of the function in the numerator of the function

partABottomFun = [1 8 16 0]; % the coefficent of the function in the denominator of the function

[partAR,~,~] = residue(partATopFun,partABottomFun); %finds the coefficents for the PFD

%problem 2 part b 

fprintf('The partial fraction decomposition has coefficents %2d %2d %2d\n\n',partAR)

fprintf('=============================\n')
fprintf('Problem 5 Part b\n')
fprintf('=============================\n')


partBTopFun = [2 10 4]; % the coefficent of the function in the numerator of the function
partBBottomFun = [1 2 0 0]; % the coefficent of the function in the denominator of the function

[partBR,~,~] = residue(partBTopFun,partBBottomFun); %finds the coefficents for the PFD

fprintf('The partial fraction decomposition has coefficents %2d %2d %2d\n\n' ...
    ,partBR)

%problem 2 part c

fprintf('=============================\n')
fprintf('Problem 5 Part c\n')
fprintf('=============================\n')


partCTopFun = [4 14]; % the coefficent of the function in the numerator of the function
partCBottomFun = [1 4 13]; % the coefficent of the function in the denominator of the function

[partCR,~,~] = residue(partCTopFun,partCBottomFun); %finds the coefficents for the PFD

fprintf('The partial fraction decomposition has coefficents %4s %4s\n\n' ...
    ,num2str(partCR(1)),num2str(partCR(2)))

%problem 2 part d

fprintf('=============================\n')
fprintf('Problem 5 Part d\n')
fprintf('=============================\n')


partDTopFun = [46 48]; % the coefficent of the function in the numerator of the function
partDBottomFun = [1 11 24 0]; % the coefficent of the function in the denominator of the function

[partDR,~,~] = residue(partDTopFun,partDBottomFun); %finds the coefficents for the PFD

fprintf('The partial fraction decomposition has coefficents %2.0f %2.0f %2d\n' ...
    ,partDR) 