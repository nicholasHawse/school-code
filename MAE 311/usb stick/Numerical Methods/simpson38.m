function I = simpson38(func,a,b,n)
% Application of the simpson38 rule
% Simpson38: composite simpson38 rule
% I = simpson38(func,a,b,n):
%     composite trapezoidal rule
% Inputs: 
% func = function to be integrated
% a, b = integration limits
% n = number of segments (default=99)
% Output: 
% I = integral estimate

% Created by: Isheeta Ranade
% Feb 09, 2017
% Updated on Feb 13, 2018

if nargin<3, error('At least 3 input arguments required'), end %Error check to ensure 3 inputs are included
if ~(b>a), error('Upper bound must be greater than lower'), end % Ensure that b is greater than a. If not exit the function

if nargin<4 || isempty(n) %Ensure that n, if specified, is evenly divisible by three.
    n = 99; 
elseif mod(n,3)>0
    error('Number of segments should be multiple of 3') 
end 

x = a; 
h = (b-a)/n; %Segment size h
m = n/3; %Determine the number of times we must apply an application of S38
s = 0; %Initialize the summation
for i = 1:m
    s = s + func(x) + 3*func(x+h) + 3*func(x+2*h) + func(x+3*h); %Include the summation of all interior segments into s
    x = x + 3*h; %Increment the evaluation point
end
I = 3*(b-a)*s/(8*n); %Compute the integral approximation

