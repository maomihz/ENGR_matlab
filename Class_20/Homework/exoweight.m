%EXOWEIGHT computes your weight on the Moon, Mars and Saturn.
%   EXOWEIGHT is a simple calculator for your weight on other celestial bodies
%   EXOWEIGHT depends on compute_gravitational_force.m
%
%   Assume 1 pound = 0.454 kilograms
%
%   The script will ask for user to input weight in pounds, and output
%   weight on the Moon, Mars and Saturn.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         5 November 2016

% Mass of the celestial bodies in kg
MASS_OF_MOON = 7.34767309e22;
MASS_OF_MARS = 6.39e23;
MASS_OF_SATURN = 5.683e26;

% Radius of the celestial bodies in m
RADIUS_OF_MOON = 1.7374e6;
RADIUS_OF_MARS = 3.39e6;
RADIUS_OF_SATURN = 58.232e6;

% conversion Constants
POUND_TO_KILOGRAMS = 0.454;
ACCELERATION_DUE_TO_GRAVITY = 9.81;

% check if required script exist
if exist('compute_gravitational_force','file')
    % input
    weight_s = input('Type your weight on earth in pounds ==> ','s');
    weight = str2double(weight_s);

    % check input is a number
    if (~isnan(weight))
        % compute the mass pound ==> kg
        mass1 = weight * POUND_TO_KILOGRAMS;

        % compute for moon
        mass2 = MASS_OF_MOON;
        distance = RADIUS_OF_MOON;
        compute_gravitational_force;
        fprintf('You would weigh %.2f lbs on the MOON!\n', gravitationalForceLbs);

        % compute for mars
        mass2 = MASS_OF_MARS;
        distance = RADIUS_OF_MARS;
        compute_gravitational_force;
        fprintf('You would weigh %.2f lbs on the MARS!\n', gravitationalForceLbs);

        % compute for saturn
        mass2 = MASS_OF_SATURN;
        distance = RADIUS_OF_SATURN;
        compute_gravitational_force;
        fprintf('You would weigh %.2f lbs on the SATURN!\n', gravitationalForceLbs);
    else
        fprintf(2, 'Weight should be a number! Check your input!\n');
    end
else
    fprintf(2, 'This script depends on compute_gravitational_force!\n');
    fprintf(2, 'Check if compute_gravitational_force.m exist.\n');
end
