function [ ] = square(fillStr, dimension)
%SQUARE draw a square filled with specified string
%   SQUARE(fillStr, dimension) draws a square (equal in width and height)
%   filled with specified string. It accept two variables as inputs:
%       fillStr - (string) the string to fill the square
%       dimension - (integer) width and height of the square. If input is not
%           an integer, it is truncated silently.
%
%   SQUARE does not have any return values.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class22 Homework1 Square
% Date:         11 November 2016

    % Check arguments
    if (ischar(fillStr) && isnumeric(dimension))

        % silently truncate non-integer
        dimension = floor(dimension);

        for i = 1:dimension % i = rows
            for j = 1:dimension % j = cols
                fprintf('%s', fillStr);
            end
            fprintf('\n'); % Start a new line
        end
    else
        fprintf(2, 'Illegal argument. Use ''help square'' to help. \n');
    end
end
