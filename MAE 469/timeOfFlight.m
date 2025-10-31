function [r1,v1] = timeOfFlight(r0,v0,tof)
% this function finds some new r and v vectors from an initial vector and a
% time of flight everything must be in canonical units

    xguess = 1000;

    mag = @(vector) sqrt(vector(1)^2 + vector(2)^2 + vector(3)^2); % magnitude of a 3 element vector

    elements = rv2elements(r0,v0,1);



    error = 1;
    x = xguess;

    while error > 1*10^(-5)

        znplus1 = x^2/elements.a;

        [s,c] = fofZ(znplus1);

        t = x^3*s + dot(r0,v0)*x^2*c+mag(r0)*x*(1-znplus1*s);

        rn = x^2*c+dot(r0,v0)*x*(1-znplus1*s)+mag(r0)*(1-znplus1*c);

        error = abs(tof - t);

        dtdx = rn;

        x = x + (tof-t)/dtdx;
        

    end

    f = 1 - elements.a/mag(r0)*(1 - cos(x/sqrt(elements.a)));

    fdot = -sqrt(elements.a)/(mag(r0)*rn)*sin(x/sqrt(elements.a));

    g = (elements.a)^2/sqrt(elements.a)*(dot(r0,v0)/sqrt(elements.a)*(1-cos(x/sqrt(elements.a)))+mag(r0)/elements.a*sin(x/sqrt(elements.a)));
    
    gdot = 1 - elements.a/rn + elements.a/rn*cos(x/sqrt(elements.a));

    check = f*gdot-fdot*g;

    r1 = f*r0 + g*v0;
    v1 = fdot*r0 + gdot*v0;

    

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