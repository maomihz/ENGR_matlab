function [ divisibleCount1, divisibleCount2, divisibleCountBoth ] = fizzbuzz(divisor1, divisor2, upperLimit)
%FIZZBUZZ play fizzbuzz game solitaire
%   FIZZBUZZ plays fizzbuzz game. The function have the following inputs:
%       divisor1 - the first divisor
%       divisor2 - the second divisor
%       upperLimit - the upper limit of numbers
%
%   The function prints the fizz buzz sequence. It also produce the following
%   outputs:
%       divisibleCount1 - count of numbers divisible by only the first divisor
%       divisibleCount2 - count of numbers divisible by only the second divisor
%       divisibleCountBoth - count of numbers divisible by both divisor

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   fizzbuzz CFU
% Date:         10 November 2016


    divisibleCount1 = 0;
    divisibleCount2 = 0;
    divisibleCountBoth = 0;

    for i = 1:upperLimit
        % check divisibles
        divisibleByNumber1 = mod(i, divisor1) == 0;
        divisibleByNumber2 = mod(i, divisor2) == 0;

        if (divisibleByNumber1 && divisibleByNumber2)
            divisibleCountBoth = divisibleCountBoth + 1;
            fprintf('fizzbuzz');
        elseif (divisibleByNumber1) % divisible by only first number
            divisibleCount1 = divisibleCount1 + 1;
            fprintf('fizz');
        elseif (divisibleByNumber2) % divisible by only second number
            divisibleCount2 = divisibleCount2 + 1;
            fprintf('buzz');
        else % divisible by neither
            fprintf('%d', i);
        end

        if (i ~= upperLimit)
            fprintf(', ')
        end
    end

    fprintf('\n');
end
