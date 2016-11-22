function [row, col] = maxindex2d(array)
%MAXINDEX2D find the index of maximum value in a 2D array
%   MAXINDEX2D(array) finds the index of the maximum value in a 2D (or less)
%   array. If there is more than one occurance of maximum value, return the
%   first occurance.
%
%   MAXINDEX2D has the following inputs:
%       array - the array to process on. Should be a 2D or less numerical
%           matrix.
%
%   MAXINDEX2D has the following outputs:
%       row - the row number of the maximum number
%       col - the column number of the maximum number

    % Validating input
    if nargin ~= 1 % Input argument is not one
        error('Input arguments should be exactly one! ');
    elseif ~isnumeric(array) % Input is not a numeric array
        error('Input need to be a numeric array! ');
    elseif isempty(array) % Input is empty
        error('Input should not be empty! ');
    else

        % Find the maximum value
        maxVal = max(array(:));

        % find the position of maximum value
        [row, col] = find(maxVal == array);

        % If more than one maximum, find one of the occurance. 
        row = row(1);
        col = col(1);
    end


end
