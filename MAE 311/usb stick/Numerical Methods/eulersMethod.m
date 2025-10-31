clear x y
xmax=100;
x(1)=0;
y(1)=0;
step=.2;
N=(xmax-x(1))/step;
for i=1:N
    slope=cos(y(i));
    x(i+1)=x(i)+step;
    y(i+1)=y(i)+step*slope;
end
plot(x,y)

