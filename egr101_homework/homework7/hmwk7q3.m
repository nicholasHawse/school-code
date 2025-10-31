clear;clc;
x = -2:.001:2;

for idx = 1:100
    y = (3/(pi*idx))*(1-(-1)^idx)*sin(pi*idx.*x/2);
    if idx == 1
        sum =  y;
    else
        sum = sum + y;
    end
end
xlabel('x')
ylabel('y')
title('siusoid plot added 100 times')
plot(x,sum);
