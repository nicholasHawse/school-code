clear; close all; clc;

x = -5:0.1:3;

Area = area(x);
rad = radius(x);
figure()
plot(x,rad)
xlabel('x (in)')
ylabel('Radius (in)')
ylim([0 6.1])

aRatio = Area./(4*pi);

[sub,sup] = mach_area(aRatio,1.3);
M = [sub(1:51) sup(52:end)];
figure()
plot(x,M)
xlabel('x (in)')
ylabel('Mach Number')


pressure = @(m,pc) (1+0.5*0.3.*m).^(-1.3/0.3)*pc;

p1 = pressure(M,500);
p2 = pressure(M,1000);

temp = @(m,tc) (1+0.5*0.3.*m).^(-1)*tc;

t = temp(M,5459.67);
figure()
plot(x,p1,'r',x,p2,'b')
legend('500 psi','1000 psi')
xlabel('x (in)')
ylabel('Pressure (psi)')


figure()
plot(x,t)
ylabel('Temperature (^oR)')
xlabel('x (in)')

function A = area(xpos)

    A = zeros(size(xpos));


    idx1 = (xpos <= -3);
    A(idx1) = 25*pi;

    idx2 = (xpos > -3) & (xpos < 0);
    A(idx2) = pi*(-1.*xpos(idx2) + 2).^2;

  
    idx3 = (xpos >= 0);
    A(idx3) = pi*(4/3.*xpos(idx3) + 2).^2;

end

function R = radius(xpos)

    R = zeros(size(xpos));


    idx1 = (xpos <= -3);
    R(idx1) = 5;

    idx2 = (xpos > -3) & (xpos < 0);
    R(idx2) = -1.*xpos(idx2) + 2;

  
    idx3 = (xpos >= 0);
    R(idx3) = 4/3*xpos(idx3) + 2;

end


function [M_sub, M_super] = mach_area(areaRatio, gamma)
    if nargin < 2
        gamma = 1.4; 
    end

    M_sub   = zeros(size(areaRatio));
    M_super = zeros(size(areaRatio));

    for k = 1:numel(areaRatio)
        M_sub(k)   = newton(areaRatio(k), 0.1, gamma);
        M_super(k) = newton(areaRatio(k), 2.0, gamma);
    end
end

function M = newton(areaRatio, Mguess, gamma)
    tol = 1e-9;
    maxIter = 1000;
    M = Mguess;

    for i = 1:maxIter
        f_val = area_ratio(M, gamma) - areaRatio;
        h = 1e-6;
        f_plus  = area_ratio(M + h, gamma) - areaRatio;
        f_minus = area_ratio(M - h, gamma) - areaRatio;
        df_val = (f_plus - f_minus) / (2*h);

        Mnew = M - f_val / df_val;

        if abs(Mnew - M) < tol
            M = Mnew;
            return;
        end
        M = Mnew;
    end
    error('Newton-Raphson did not converge');
end

function iteration = area_ratio(M, gamma)
    term1 = 1/M;
    term2 = ((2/(gamma+1))*(1 + (gamma-1)/2*M^2))^((gamma+1)/(2*(gamma-1)));
    iteration = term1 * term2;
end
