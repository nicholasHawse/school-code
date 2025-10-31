% Problem 23.13 Stiff example ODE solver
clear, clc
format compact

dCdt = @(t,C) [-0.013*C(1)-1000*C(1)*C(3);
               -2500*C(2)*C(3);
               -0.013*C(1)-1000*C(1)*C(3)-2500*C(2)*C(3)];
tspan = [0 50];
C0 = [1; 1; 0];

tic
[t1, C1] = ode45(dCdt, tspan, C0);
toc
length(C1)

tic
[t2, C2] = ode23s(dCdt, tspan, C0);
toc
length(C2)
figure(6)
subplot(2,1,1)
plot(t1, C1(:,1), '-', t1, C1(:,2), '-.', t1, C1(:,3), ':')
title('ODE45')
v = axis();
v(3) = -0.25;
axis(v)
legend('c_1', 'c_2', 'c_3', 'location','eastoutside')

subplot(2,1,2)
plot(t2, C2(:,1), '-', t2, C2(:,2), '-.', t2, C2(:,3), ':')
axis(v)
title('ODE23s')
legend('c_1', 'c_2', 'c_3', 'location','eastoutside')