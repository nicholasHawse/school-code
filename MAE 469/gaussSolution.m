function [V1s,V2s,V1l,V2l] = gaussSolution(r1,r2,tof)
    % this function finds the solution to gausses problem when given values
    % for position in DU and a TOF in TU. The s are the short way and
    % the l is the long way.

    zguess = 10;

    mag = @(vector) sqrt(dot(vector,vector)); % magnitude of a vector

    dtheta = acos(dot(r1,r2)/(mag(r1)*mag(r2))); % the angle between the position vectors

    A = (sqrt(mag(r1)*mag(r2))*sin(dtheta))/sqrt(1-cos(dtheta)); 


    error = 1;
    znplus1 = zguess;

    while error > 1*10^(-5)
        [s,c] = fofZ(znplus1);

        y = mag(r1) + mag(r2) - A*(1-znplus1*s)/sqrt(c);

       x = sqrt(y/c);

       t = x^3*s + A*sqrt(y);

       error = abs(tof - t);
     

        dsdz = (c - 3*s)/2*znplus1;

        dcdz = (1 - znplus1*s - 2*c)/2*znplus1;

       dtdz = x^3 * (dsdz - 3*s*dcdz/(2*c)) + A/8 * (3*s*sqrt(y)/c + A/x);

      znplus1 = znplus1 + (tof-t)/dtdz;

    end

    f = 1 - y/mag(r1);
    fdot = -x/(mag(r1)*mag(r2))*(1-znplus1*s);
    g = A*sqrt(y);
    gdot = 1 - y/mag(r2);

    V1s = (r2 - f*r1)/g;
    V2s = (gdot*r2 - r1)/g;


    check = f*gdot-fdot*g;

    dthetal = 2*pi-dtheta; % the angle between the position vectors

    Al = (sqrt(mag(r1)*mag(r2))*sin(dthetal))/sqrt(1-cos(dthetal)); 


    error = 1;
    znplus1 = zguess;

    while error > 1*10^(-5)
        [s,c] = fofZ(znplus1);

        y = mag(r1) + mag(r2) - Al*(1-znplus1*s)/sqrt(c);

       x = sqrt(y/c);

       t = x^3*s + Al*sqrt(y);

       error = abs(tof - t);

        dsdz = (c - 3*s)/2*znplus1;

        dcdz = (1 - znplus1*s - 2*c)/2*znplus1;

       dtdz = x^3 * (dsdz - 3*s*dcdz/(2*c)) + Al/8 * (3*s*sqrt(y)/c + Al/x);

      znplus1 = znplus1 + (tof-t)/dtdz;

    end

    f = 1 - y/mag(r1);
    fdot = -x/(mag(r1)*mag(r2))*(1-znplus1*s);
    g = Al*sqrt(y);
    gdot = 1 - y/mag(r2);

    V1l = (r2 - f*r1)/g;
    V2l = (gdot*r2 - r1)/g;


    check = f*gdot - fdot*g;

    function [s,c] = fofZ(z) % this function finds the s and c values for a given z

    if z > 0.1
        s = (sqrt(z)-sin(sqrt(z)))/z^(3/2);
        c = (1-cos(sqrt(z)))/z;
    elseif z < -0.1
        s = (sinh(-z)-sqrt(-z))/(-z)^(3/2);
        c = (1 - cosh(-z))/z;
    else
        s = 1/6 - z/factorial(5) + z^2/factorial(7) - z^3/factorial(9);
        c = 1/2 - z/factorial(4) + z^2/factorial(6) - z^3/factorial(8);

    end
    end

end