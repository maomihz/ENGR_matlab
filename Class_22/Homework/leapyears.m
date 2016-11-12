function [ ] = leapyears(startYear, endYear)
%LEAPYEAR compute and print leapyears
%   LEAPYEAR(start,end) computes and prints leapyears in a range (inclusive)
%
%   LEAPYEAR takes two arguments:
%       startYear - year start to print
%       endYear - year end to print
%
%   It has no return values. Computed leapyears are printed line by line.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class22 Homework2 Leapyears
% Date:         11 November 2016

    % From start to end, inclusive
    for i = startYear : endYear
        isLeapyear = false;

        % Divisible by 4 but not divisible by 100 is a leapyear
        if (mod(i, 4) == 0 && mod(i, 100) ~= 0)
            isLeapyear = true;
        end

        % Divisible by 100 and also divisible by 400 is a leapyear
        if (mod(i, 100) == 0 && mod(i, 400) == 0)
            isLeapyear = true;
        end

        % Print the year
        if (isLeapyear)
            fprintf('%d\n', i);
        end
    end

end
