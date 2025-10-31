clear;
close all;
clc;
temp_f = [-495:400];
temp_c = temp_f -32;
temp_c = temp_c*(5/9);
figure
plot(temp_f,temp_c)
grid on
xlim({-460,400})
title ('temp i f ploted aginst c')
xlabel('degres f')
ylabel('degres c')