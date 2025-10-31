clear;
clc;
clf;
close all;

Isp = 200;
initialmass = 53;
finalmass = 53-10;
timebo = 3.2;

time = 0:0.2:45;

[acc,velocity,height] = rocket_trajectory(time,Isp,initialmass,finalmass,timebo);

figure()
plot(time,height)
title('time vs height');
ylabel('height (ft)');
xlabel('time (s)');

figure()
plot(time,velocity)
hold on;
title('time vs velocity');
ylabel('velocity (ft/s)');
xlabel('time (s)');

figure()
plot(time,acc)
hold on;
title('time vs acceleration');
ylabel('acceleration (ft/s\^2)');
xlabel('time (s)');


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
            vb = isp * g0 * log(m0 / mf);
            hb = isp * g0 * tb - isp * g0 * mf / mdot * log(m0 / mf) - 0.5 * g0 * tb^2;
            dt = ti - tb;
            a(i) = -g0;
            v(i) = vb - g0 * dt;
            h(i) = hb + vb * dt - 0.5 * g0 * dt^2;
        end
    end
end


