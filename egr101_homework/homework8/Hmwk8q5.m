clear;clc;close all; % setup things

Range = 0:.001:10; % makes range vector

power_reflected1 = ((10*10000)./(4*pi.*Range.^2)).*(.1./(4*pi.*Range.^2))*10; % the equations for each of the power reflected
power_reflected2 = ((10*10000)./(4*pi.*Range.^2)).*(1./(4*pi.*Range.^2))*10;
power_reflected3 = ((10*10000)./(4*pi.*Range.^2)).*(10./(4*pi.*Range.^2))*10;


semilogy(Range,power_reflected1) % ploting of each of the power vs range
hold on
semilogy(Range,power_reflected2)
semilogy(Range,power_reflected3)

legend('sigma.1','sigma 1', 'sigma 10') % lableing the plot
title('recive power vs range')
xlabel('range')
ylabel('recive power')

test1 = Range(power_reflected1 ~= .1) % calculations for the values required
test2 = Range(power_reflected2 ~= .1)
test3 = Range(power_reflected3 ~= .1)

test4 = power_reflected1(Range == 2)
test5 = power_reflected1(Range == 2)
test6 = power_reflected1(Range == 2)

