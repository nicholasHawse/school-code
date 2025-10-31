function[xr, fx, ea,iterationCount] = bisect(f, xL, xu, et)
%bisect: bisection root locator that finds roots between XL and xu
% Inputs: 
% f - function to be evaluated
% xL, xu - lower and upper bounds, respectively
% et - maximum allowable error (default 0.0001%)
% Outputs:
% xr - estimated root location
% fx - input function value at the estimated root location
% ea - magnitude of approximate relative error (%)

% Created by: Isheeta Ranade
% 22 January, 2018

if nargin<3, error('At least 3 input arguments required'), end % Check to ensure 3 inputs are included
test = f(xL)*f(xu); % Create a variable test which is used to see if the sign changes between xL and xu.
if test > 0, error('No sign change f(xL) and f(xu)'), end
if nargin < 4 | isempty(et), et=0.0001; end % Ensure et is specified

xr = xL;
ea = 100; 
iterationCount = 0;
for i = 1:50
    xrold = xr;
    xr = (xL + xu)/2;
   sgnchng = f(xL)*f(xr);
   if sgnchng < 0
       xu = xr;
       ea = abs((xr-xrold)/xr)*100;
   elseif sgnchng > 0
       xL = xr;
       ea = abs((xr-xrold)/xr)*100;
   else
       ea = 0;
   end
       if ea < et
           break
       end
       iterationCount = iterationCount +1;
end % end of for loop
 fx = f(xr);      
end
