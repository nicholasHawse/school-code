function [] = displayOrbit(elements1,elements2,elements3,elements4,elements5)
%given a set of orbital elements this function plots the orbit
%   pass in two sets of orbital elements

% orbital points initilize
x1 = zeros(100,1);
y1 = zeros(100,1);
z1 = zeros(100,1);

x2 = zeros(100,1);
y2 = zeros(100,1);
z2 = zeros(100,1);

x3 = zeros(100,1);
y3 = zeros(100,1);
z3 = zeros(100,1);

x4 = zeros(100,1);
y4 = zeros(100,1);
z4 = zeros(100,1);

x5 = zeros(100,1);
y5 = zeros(100,1);
z5 = zeros(100,1);

for i = 1:1:360
    elements1.nu = (i-1);
    [rtemp,~] = elements2rv(elements1,1);
    x1(i) = rtemp(1);
    y1(i) = rtemp(2);
    z1(i) = rtemp(3);

    elements2.nu = (i-1);
    [rtemp,~] = elements2rv(elements2,1);
    x2(i) = rtemp(1);
    y2(i) = rtemp(2);
    z2(i) = rtemp(3);

    elements3.nu = (i-1);
    [rtemp,~] = elements2rv(elements3,1);
    x3(i) = rtemp(1);
    y3(i) = rtemp(2);
    z3(i) = rtemp(3);

    elements4.nu = (i-1);
    [rtemp,~] = elements2rv(elements4,1);
    x4(i) = rtemp(1);
    y4(i) = rtemp(2);
    z4(i) = rtemp(3);

    elements5.nu = (i-1);
    [rtemp,~] = elements2rv(elements5,1);
    x5(i) = rtemp(1);
    y5(i) = rtemp(2);
    z5(i) = rtemp(3);
end

plot3(x1,y1,z1,'b')
hold on;
plot3(x2,y2,z2,'g')
plot3(x3,y3,z3,'y')
plot3(x4,y4,z4,'m')
plot3(x5,y5,z5,'k')
plot3(0,0,0,'yo')


end