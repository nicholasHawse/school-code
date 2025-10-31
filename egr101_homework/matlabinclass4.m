% y = ut -(g/2)t^2
%u is speed 
%t is time
%g is 9.8 m/s^2
%y is height
u = input('enter a integer speed');
G = 9.8; 

t = (0:.001:12);
y = u*t - G/2 *t.^2;
plot(t,y)
title('matlab mass destruction missile')
ylabel('height meters')
xlabel('time sec')
%ylim([0 max(y)])