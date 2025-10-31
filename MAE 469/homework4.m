clear;
clf;
close all;

duE = 6378.136; % conversion from du earth to km
tuE = 806.8118744; % converson from tu earth to seconds
muE = 3.986004418*10^5; % mu for earth

% problem 1

element.e = 0.6;
element.a = 9*10^5; %km

E = @(e,nu) acos((e+cosd(nu))/(1+e*cosd(nu)));

n = @(mu,a) sqrt(mu/(a^3));

M = @(E,e) E - e*sin(E);

deltat = @(M,n) M/n;

E1 = E(element.e,300);
E2 = E(element.e,190);

meanMotion = n(muE,element.a);

M1 = M(E1,element.e);
M2 = M(E2,element.e);
dt = (M2-M1)/meanMotion;
dtHours = dt/3600

% problem 2

r2 = [2 -1.287 -0.3];
v2 = [0.3 -0.63 0.229];

elements = rv2elements(r2,v2,1);

t2 = 2.22*3600;
n = sqrt(muE/(elements.a*duE)^3);

e0 = acos((elements.e+cosd(elements.nu))/(1 + elements.e*cosd(elements.nu)));

M0 = e0 - elements.e*sin(e0);

k = 0;

en = zeros(100,1);
Mn = zeros(100,1);

for iteration = 1:100
    
    dmnden = 1 - elements.e*cos(en(iteration));

    Mn(iteration) = en(iteration) - elements.e*sin(en(iteration));

    en(iteration+1) = en(iteration) + ((n*t2 - 2*k*pi + M0) - Mn(iteration))/dmnden;

    delta = abs(en(iteration+1)-en(iteration));

    if iteration == 1
        fprintf('  I         En    Mn-Mn+1      dM/dE       En+1\n');
        fprintf('-----------------------------------------------\n');
    end

    fprintf('%3d %10.4f %10.4f %10.4f %10.4f\n',iteration,en(iteration),(Mn(iteration)- Mn(iteration+1)),dmnden,en(iteration+1))

    if delta < 10^(-7)
        nu = rad2deg(acos((elements.e-cos(en(iteration+1)))/(elements.e*cos(en(iteration+1))-1)));
    break;
    end
end
%problem 3

delta = 1;

rn = zeros(100,1);

dtdx = zeros(100,1);

x = zeros(100,1);

tn = zeros(100,1);

r0 = [-0.5 0 0];
v0 = [0 1.999 0];

elements = rv2elements(r0,v0,1);

t3 = 10^3; 

mu = 1;

x(1) = sqrt(mu)*3.1415926/elements.a;

mag = @(vector) sqrt(vector(1)^2 + vector(2)^2 + vector(3)^2);

for iteration = 1:100

    rn(iteration) = elements.a + elements.a*(dot(r0,v0)/sqrt(mu*elements.a)*sin(x(iteration)/sqrt(elements.a))+(mag(r0)/elements.a-1)*cos(x(iteration)/sqrt(elements.a)));

    dtdx(iteration) = rn(iteration)/mu;

    tn(iteration) = elements.a/sqrt(mu)*(x(iteration)-sqrt(elements.a)*sin(x(iteration)/sqrt(elements.a))) + dot(r0,v0)/mu*elements.a*(1-cos(x(iteration)/sqrt(elements.a)))+mag(r0)*sqrt(elements.a)/sqrt(mu)*sin(x(iteration)/sqrt(elements.a));

    x(iteration+1) = x(iteration) + (t3-tn(iteration))/dtdx(iteration);

    delta = abs(t3 - tn(iteration));

    if iteration == 1
        fprintf('  I         Xn        \x0394tn      dt/dx\n');
        fprintf('------------------------------------\n');
    end

    fprintf('%3d %10.4f %10.4f %10.4f\n',iteration,x(iteration),tn(iteration),dtdx(iteration))

    if delta < 10^(-7)
        f = 1- elements.a/mag(r0)*(1-cos(x(iteration+1)/sqrt(elements.a)));
        g = elements.a^2/sqrt(elements.a*mu)*(dot(r0,v0)/sqrt(mu*elements.a)*(1 - cos(x(iteration+1)/sqrt(elements.a))) + mag(r0)/elements.a*sin(x(iteration+1)/sqrt(elements.a)));
        fdot = -sqrt(mu*elements.a)/mag(r0)/rn(iteration)*sin(x(iteration+1)/sqrt(elements.a));
        gdot = 1- elements.a/rn(iteration)+elements.a/rn(iteration)*cos(x(iteration+1)/sqrt(elements.a));
        check = f*gdot-fdot*g ;
        rnew = f.*r0 + g.*v0;
        vnew = fdot.*r0 + gdot.*v0;

    break;
    end
end