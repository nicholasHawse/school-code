clear;clc;

n = 1098;

x = 1:n;

f = n./x;

factors = x(mod(n,x) == 0)
%1           2           3           6           9          18          61
%122         183         366         549         1098