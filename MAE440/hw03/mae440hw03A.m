clear; close all; clc; clf; 

%eulers method mae 440


clear;
clc;
clf;
close all;

Isp = 200;
initialmass = 53;
finalmass = 53-10;
timebo = 3.2;
mdot = (initialmass-finalmass)/timebo;

time = 0:0.2:50;

[acc,velocity,height] = rocket_trajectory(time,Isp,initialmass,finalmass,timebo);


function [a, v, h] = rocket_trajectory(t, isp, m0, mf, tb)
    mdot = (m0 - mf) / tb;
    g0 = 32.2;

    a = zeros(size(t));
    v = zeros(size(t));
    h = zeros(size(t));

    for i = 1:length(t)
        ti = t(i);
        if ti <= tb
            m = m0 - mdot * ti;
            a(i) = -g0 + (mdot * isp * g0) / m;
            v(i) = isp * g0 * log(m0 / m) - g0 * ti;
            h(i) = isp * g0 * ((m0 - m) / mdot - m * log(m0 / m) / mdot) - 0.5 * g0 * ti^2;
        else
            vb = isp * g0 * log(m0 / mf) - 32.2*3.2;
            hb = isp * g0 * tb - isp * g0 * mf / mdot * log(m0 / mf) - 0.5 * g0 * tb^2;
            dt = ti - tb;
            a(i) = -g0;
            v(i) = vb - g0 * dt;
            h(i) = hb + vb * dt - 0.5 * g0 * dt^2;
        end
    end
end




Isp = 200;
initialmass = 53;
finalmass = 53-10;
timebo = 3.2;
mdot = (initialmass-finalmass)/timebo;
m = zeros(1001,1);
a = zeros(1001,1);
v = zeros(1001,1);
h = zeros(1001,1);
t = 0:0.2:200;
m(1) = initialmass;
v(1) = 0;
h(1) = 0;
cd = 0.3;
Af = 0.2089819;


for i = 1:length(t)-1

    rho = @(alt) (1.255e-11)*alt^2 - (1.9453e-6)*alt + 0.07579;

        if t(i) <= timebo

            m(i+1) = m(i) - mdot*( t(i+1) - t(i) );

            a(i) = mdot*32.2*200/m(i) - 32.2 - rho(h(i))*cd*v(i)*abs(v(i))*Af/(2*m(i));

        else

            m(i+1) = finalmass;

            a(i) = -32.2 - rho(h(i))*cd*v(i)*abs(v(i))*Af/(2*m(i));

        end

    v(i+1) = v(i) + a(i)*( t(i+1) - t(i) );

    h(i+1) = h(i) + ( v(i+1) + v(i) )/2 * ( t(i+1) - t(i) );

end


figure()
plot(t,h)
hold on;
plot(time,height)
title('time vs height');
ylabel('height (ft)');
xlabel('time (s)');
legend('With Drag','No Drag')
xlim([0 42])

figure()
plot(t,v)
hold on;
plot(time,velocity)
title('time vs velocity');
ylabel('velocity (ft/s)');
xlabel('time (s)');
legend('With Drag','No Drag')
xlim([0 42])

figure()
plot(t,a)
hold on;
plot(time,acc)
title('time vs acceleration');
ylabel('acceleration (ft/s\^2)');
xlabel('time (s)');
legend('With Drag','No Drag')
xlim([0 10])


rho = @(alt) (1.255e-11).*alt.^2 - (1.9453e-6).*alt + 0.07579;
alt = 0:1:100000;
density = rho(alt);
density(82000:end) = 0;


figure()
plot(alt,density)
title('Density Vs. Altitude')
xlabel('alt (ft)')
ylabel('density (lb_m/ft^3)')