clear;
clc;
close all;
mag = @(vector) sqrt(vector(1)^2 + vector(2)^2 + vector(3)^2); % magnitude of a 3 element vector

%problem1

%problem2

%problem3

%problem4

% constants for the sun
duS = 1.4959965e8; % conversion from du sun to km
au = duS; % a sun du is sometimes called an au
tuS = 5.0226757e6; % converson from tu sun to seconds
muS = 1.3271544e11; % mu for sun km^3/s^2


re0 = [0.9422 -0.3614 -1.49e-7]; % AU

ve0 = [0.3419 0.93 8.543e-7]; % AU/TU

rm0 = [1.3871 0.1765 -0.0304]; % AU

vm0 = [-0.0714 0.8766 0.0201]; % AU/TU 

% departure time in tu
ti = 706*24*60*60/tuS;

% time of flight in tu
tof = 210*24*60*60/tuS;

% departure position and velocity of mars in heliocentric frame
[rd,vd] = timeOfFlight(rm0,vm0,ti); 

% arrival time from start
ta = ti + tof;

% departure position and velocity of earth in heliocentric frame
[ra,va] = timeOfFlight(re0,ve0,ta); 

% earth nu
earthElements = rv2elements(ra,va,1);
earthElements.nu

% mars nu
marsElements = rv2elements(rd,vd,1);
marsElements.nu

% phase 2: we have to r vectors find v vectors with gauss's 
[v1,v2] = gaussSolution(rd,ra,tof);

transferElements = rv2elements(rd,v1,1)

transferElements = rv2elements(ra,v2,1)

vinf1 = mag(v1 - vd)

vinf2 = mag(v2 - va)




