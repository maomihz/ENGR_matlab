function [numberPath, maxNumber] = hailstone(number)
%HAILSTONE run the hailstone algorithm
%   HAILSTONE(number) run the hailstone algorithm and calculate the path it need
%   to take to reach the end.
%
%   Input list:
%       number - the number to run hailstone algorithm
%
%   Along the iteration, it also finds the largest possible number
%   it reached and return as the second output.
%
%   Output list:
%       numberPath - the path needed to reach the end
%       maxNumber - The maximum number it reached

    number = floor(number);

    numberPath = 0;
    maxNumber = number;
    while (number > 1)
        if (mod(number, 2) == 0) % number is even
            number = number / 2;
        else % number is odd
            number = 3 * number + 1;
        end

        maxNumber = max(maxNumber, number); % keep track of the largest number
        numberPath = numberPath + 1; % keep track of the path
    end
end
