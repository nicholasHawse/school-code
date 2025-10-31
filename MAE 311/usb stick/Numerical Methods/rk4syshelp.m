function [tp,yp] = rk4sys(dydt, tspan, y0, h, varargin)
% rk4sys: fourth-order Runge-Kutta for a system of ODEs
%   [t,y] = rk4sys(dydt, tspan, y0, h, p1, p2, ...): integrates
%           a system of ODEs with fourth-order RK method
%
% input:
%   dydt = name of the M-file that evaluates the ODEs
%   tspan = [ti, tf]; initial and final times with output
%                     generated at interval of h, or
%     = [t0 t1 ... tf]; specific times where solution output
%   y0 = initial value of dependent variables
%   h = step size
%   p1, p2, ... = additional parameters used by dydt
%
% output:
%   tp = vector of independent variables
%   yp = vector of solution for dependent variables

