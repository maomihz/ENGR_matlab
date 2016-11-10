%KAPREKAR_SUM compute sum of number of times to run kaprekar's routine to
%reach the kaprekar's constant from 0000 - 9999
%
%   the output is printed and stored in routeSum variable.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class 22 bonus
% Date:         10 November 2016

routeSum = 0;
for i = 0:9999
    routeSum = routeSum + kaprekar_iteration(i);
end
fprintf('Sum is: %d\n', routeSum);
