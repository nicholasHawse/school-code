clear
clc
f = @(x) sqrt(19.62.*x).*tanh(sqrt(1.23*x).*2.5)-5;

x = 0:.0000001:100;

plot(x,f(x))
grid

