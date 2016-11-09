function [x1,x2] = solve_quadratic (a, b, c)
%SOLVE_QUADRATIC solve quadratic equations
%   SOLVE_QUADRATIC(a,b,c) solves the quadratic equations using quadratic
%   formula, and it outputs two roots x1 and x2.
%
%   Inputs are given by argument, and stored in variable a,b,c. Equation should
%   use the form ax^2+bx+c=0.
%
%   If a is zero, then x1 is solved as if it is a linear equation, and x2
%   is given a value NaN. Error message would be printed.
%
%   Complex root is possible, and if input is not scalar, both x1 and x2 would
%   be set to NaN.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Homework-Class21
% Date:         10 November 2016

    % 3 arguments should exist
    if (exist('a', 'var') && exist('b', 'var') && exist('c', 'var'))

        % All three numbers should be numeric number
        if (isscalar(a) && isscalar(b) && isscalar(c))

            % a should not be zero
            if (a ~= 0)
                % Discriminant is b^2-4ac
                discriminant = b ^ 2 - 4 * a * c;

                % Discriminate < 0, there would be complex roots
                if (discriminant < 0)
                    fprintf('WARNING: The input function would produce complex roots. \n');
                end

                % find roots using formula
                root1 = (-b + sqrt(discriminant)) / (2 * a);
                root2 = (-b - sqrt(discriminant)) / (2 * a);

                % x1 is the smaller of the two and x2 bigger
                x1 = min(root1, root2);
                x2 = max(root1, root2);

            else % a is equal to zero
                fprintf('WARNING: Constant a is zero. Will solve it as linear function. \n');
                x1 = -c/b;
                x2 = NaN;
            end
        else % inputs are not scalar value
            fprintf(2, 'Inputs are not scalar. Aborting program. \n');
            x1 = NaN;
            x2 = NaN;
        end
    else % Arguments probably not passed
        fprintf(2, 'Argument not enough. Aborting program. \n');
        x1 = NaN;
        x2 = NaN;
    end
end
