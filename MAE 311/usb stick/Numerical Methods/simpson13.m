function I = simpson13(func,a,b,n)
% Application of the simpson13 rule
% Simpson13: composite simpson13 rule
% I = simpson13(func,a,b,n):
%     composite trapezoidal rule
% Inputs: 
% func = function to be integrated
% a, b = integration limits
% n = number of segments (default=100)
% Output: 
% I = integral estimate

% Created by: Isheeta Ranade
% Feb 09, 2017
% Updated on Feb 13, 2018

if nargin<3, error('At least 3 input arguments required'), end %Error check to ensure 3 inputs are included
if ~(b>a), error('Upper bound must be greater than lower'), end % Ensure that b is greater than a. If not exit the function

if nargin<4 || isempty(n) %Ensure n is specified. If not set to 100. Also we must ensure that it is evenly divisible by two.
    n = 100; 
elseif mod(n,2)>0
    error('Number of segments should be multiple of 2') 
end 

x = a; 
h = (b-a)/n; %Segment size h
m = n/2; %Determine the number of times we must apply an application of S13
s = 0; %Initialize the summation
for i = 1:m
    s = s + func(x) + 4*func(x+h) + func(x+2*h); %Include the summation of all interior segments into s
    x = x + 2*h; %Increment the evaluation point
end
I = (b-a)*s/(3*n); %Compute the integral approximation

