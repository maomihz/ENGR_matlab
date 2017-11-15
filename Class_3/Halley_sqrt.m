function result = Halley_sqrt(number)
%HALLEY_SQRT compute the square root of a number with Halley's Algorithm
%   HALLEY_SQRT(number) computes the square root of a number with Halley's
%   Algorithm.
%
%   HALLEY_SQRT has the following inputs:
%       number - the number to compute square root ( >= 1)
%
%   HALLEY_SQRT has the following outputs:
%       result - the square root of the number

    % Input should be greater than or equal to 1
    if ~isreal(number) || number < 1
        error('Input number should be greater than or equal to 1!!!');
    end

    % Initial Guess is 1
    x = 1;
    while true
        % Doing some intermediate stuff
        y = 1 / number * x ^ 2;
        xNext = x / 8 * (15 - y * (10 - 3 * y));
        diff = xNext - x;

        % Smaller than a threhold
        if diff <= 0.001
            result = xNext;
            break;
        end

        % Prepare for the next round
        x = xNext;
    end

end
