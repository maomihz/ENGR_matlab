function solution = solv_equation(A, b)
%SOLV_EQUATION solve equation
%   SOLV_EQUATION(A, b) solves equation. The matrix representations of
%   the equation are passed to the function as arguments, and a vector of
%   solutions is returned.
%
%   SOLV_EQUATION has the following inputs:
%       A - the left side of the equation
%       b - the right side of the equation
%
%   SOLV_EQUATION has the following outputs:
%       solution - a colume vector of solutions
%
% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 6
% Date:         1 Feburary 2017

    % check for square matrix
    if size(A, 1) ~= size(A, 2)
        error('Input matrix must be a square!!! ');
    end

    % if a row vector convert to column vector
    if size(b, 1) == 1
        b = b';
    end

    % Check for column vector
    if size(b, 2) ~= 1
        error('Input vector must be column vector!!! ');
    end

    % Check for dimension agree
    if size(A, 1) ~= size(b, 1)
        error('Input dimension must agree!!! ');
    end

    % Check for determinant
    if det(A) == 0
        error('The equation is not valid!!! ')
    end

    solution = A \ b;


end
