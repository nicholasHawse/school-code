clear;clc;
x = -2:.001:2;

y1 = (3/(pi*1))*(1-(-1)^1)*sin(pi*1.*x/2);
y2 = (3/(pi*2))*(1-(-1)^2)*sin(pi*2.*x/2);
y3 = (3/(pi*3))*(1-(-1)^3)*sin(pi*3.*x/2);
y4 = (3/(pi*4))*(1-(-1)^4)*sin(pi*4*x/2);
y5 = (3/(pi*5))*(1-(-1)^5)*sin(pi*5*x/2);

sum = y1+y2+y3+y4+y5;

hold on
plot(x,y1)
plot(x,y2)
plot(x,y3)
plot(x,y4)
plot(x,y5)
plot(x,sum)
xlabel('x')
ylabel('y')
legend('y1','y2','y3','y4','y5','sum','Location','northwest')