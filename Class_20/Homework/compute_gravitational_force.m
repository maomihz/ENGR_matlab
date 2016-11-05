%COMPUTE_GRAVITATIONAL_FORCE computes the force of gravity between two objects
%   given their masses and the distance between them
%
%   COMPUTE_GRAVITATIONAL_FORCE is a simple calculator for gravity.
%
%   Force of gravity between two objects is proportional to
%   the product of the masses, and inversely proportional
%   to the square of the distance between them
%
%   Assume 1 pound on Earth is the same as 4.4537 Newtons of force on Earth.
%
%   The Following variables should already exist in workspace:
%       mass1 - Mass in kg for first object
%       mass2 - Mass in kg for second object
%       distance - distance in m for distance between them
%
%   The following variables would be overwritten as result:
%       gravitationalForceNewtons - Calculated gravitational force in N
%       gravitationalForceLbs - Calculated gravitational force in Lbs

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         5 November 2016

% Constants
POUND_TO_NEWTON = 4.4537; % 1 pound in Newton
GRAVITATIONAL_CONSTANT = 6.674e-11;

% Test for variable existance
if exist('mass1', 'var') && exist('mass2', 'var') && exist('distance', 'var')

    % Process & Output
    tmp = mass1 * mass2 / distance^2; % m1 * m2 / d^2, no G involved
    gravitationalForceNewtons = GRAVITATIONAL_CONSTANT * tmp;  % Result above * G
    gravitationalForceLbs = gravitationalForceNewtons / POUND_TO_NEWTON;


else
    fprintf(2, 'WARNING: One or more required variables does not exist! \n');
    fprintf(2, 'Check for the following: mass1, mass2, distance. \n');
end
