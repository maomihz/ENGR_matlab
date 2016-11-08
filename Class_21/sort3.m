function [a,b,c] = sort3 (x,y,z)
%SORT3 sort 3 numbers
%   SORT3(x,y,z) sorts 3 numbers in descending order.
%
%   The function take 3 numbers as its arguments stored in x, y, z
%   and return 3 numbers a, b, c, and the first of which is the maximum value.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         8 November 2016

if (x > y)
    if (x > z)
        if (y > z)
            a = x;
            b = y;
            c = z;
        else % y < z
            a = x;
            b = z;
            c = y;
        end
    else % x < z
        a = z;
        b = x;
        c = y;
    end
else % x < y
    if (x > z)
        a = y;
        b = x;
        c = z;
    else % x < z
        if (y > z)
            a = y;
            b = z;
            c = x;
        else % y < z
            a = z;
            b = y;
            c = x;
        end
    end
end
