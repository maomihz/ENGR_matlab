%LIGHTNING computes the distance between you and a lightning strike
%   LIGHTNING computes the distance between you and a lightning strike
%
%   LIGHTNING overwrites these variables:
%       time - the time between seeing a lightning strike and hearing it
%       distanceInFeet - the total distance in feet
%       ditanceInMiles - the total distance in miles
%
%
%   Author: Xucheng Guo

% constants
SPEED_OF_SOUND = 1100;
FEET_TO_MILE = 5280;

% input
time = input('Type the time in seconds ==> ');

% processing
distanceInFeet = SPEED_OF_SOUND * time;
distanceInMiles = distanceInFeet / FEET_TO_MILE;

% output
fprintf('Distance to the lightning strike is: %.2f miles\n', distanceInMiles);
