g = 10;
h = 7;
k = 1;


d1 = 42*pi/h
d2 = sqrt(g*k)+h
d3 = d2 - d1

fprintf('%.4f',d3)

true_error = 2.5 - 2.682

mprae = @(current,previous) abs((current-previous)/previous)*100;

current = 18.6;
previous = 16.5;

 mpre = mprae(current,previous)

 f = @(x) = -x^2 + x + exp(x);