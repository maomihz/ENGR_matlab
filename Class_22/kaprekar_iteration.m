function loopCount = kaprekar_iteration(inputNumber)
%KAPREKAR_ITERATION implementation of kaprekar's routine
%   KAPREKAR_ITERATION(number) implements the kaprekar's routine given
%   a 4-digit number (0~9999) and return the number of iterations.
%
%   The input should be an integer, otherwise the decimal part would be
%   truncated silently.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class 22 bonus
% Date:         10 November 2016


    % Ensure an integer
    inputNumber = floor(inputNumber);

    if (inputNumber >= 0 && inputNumber <= 9999)

        % initialize the counter
        loopCount = 0;

        while (inputNumber ~= 6174 && inputNumber ~= 0)
            inputStr = num2str(inputNumber);
            inputStr = [repmat('0', 1, 4 - size(inputStr, 2)), inputStr];

            % Sort the numbers
            descendingSorted = sort(inputStr, 2, 'descend');
            ascendingSorted = sort(inputStr, 2);

            difference = abs(str2double(descendingSorted) - str2double(ascendingSorted));
            inputNumber = difference;

            loopCount = loopCount + 1;
        end

    else % input not in range
        fprintf(2, 'Input should be a 4-digit number! \n');
    end
end
