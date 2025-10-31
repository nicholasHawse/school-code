function I = trap(func,a,b,n,varargin)
% trap: composite trapezoidal rule quadrature
% I = trap(function,a,b,n,p1,p2,...): 
%           composite trapezoidal rule
%
% Inputs:
% func = function to be integrated
% a,b = integration limits
% n = number of segments (default = 100)
% p1, p2,... = additional parameters used by func
% Output:
% integral estimate

%Created by: Isheeta Ranade
% Feb 08, 2017
% Updated on Feb 13, 2018

if nargin<3, error('At least 3 input arguments required'), end %Error check to ensure 3 inputs are included
if ~(b>a), error('Upper bound must be greater than lower'), end % Ensure that b is greater than a. If not exit the function
if nargin<4 || isempty(n), n = 100; end %Ensure n is specified. If not set to 100

x = a;
h = (b-a)/n; %Compute step size h
s = func(a,varargin{:});
for i = 1:n-1
    x = x+h; %Increment location of x
    s = s + 2*func(x,varargin{:}); %Include the summation of all interior segments into s
end
s = s + func(b,varargin{:}); %Add the last term to s
I = (b-a)*s/(2*n); %Compute the integral approximation using the summation term.