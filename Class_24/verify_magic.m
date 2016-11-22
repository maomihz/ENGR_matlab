function isMagicSquare = verify_magic(squareMatrix)
%VERIFY_MAGIC verify if a square matrix is magic square
%   VERIFY_MAGIC(squareMatrix) verifys if a square matrix is a magic square.
%
%   A magic square is defined as follows:
%       - It is a square matrix
%       - contains integers 1 to N^2 exactly once
%       - each and every row, column and diagnoal has the same sum
%   If all of above is satisfied, function will return true, and otherwise,
%       false.
%
%   VERIFY_MAGIC has the following inputs
%      squareMatrix - the matrix to validate
%
%   VERIFY_MAGIC has the following outputs:
%       isMagicSquare - (Logic) whether the matrix is a magic squareMatrix

    if nargin ~= 1
        error('Number of input arguments should be exactly one! ');
    elseif size(squareMatrix,1) ~= size(squareMatrix,2)
        error('Input is not a square matrix! ')
    else
        % side length
        rows = size(squareMatrix,1);

        % Assume it is a magic square in the beginning
        % Now check the if it contains integers 1 to N^2 exactly once

        % Initialize an empty logical array with N^2 length
        numCheck = false(1,rows ^ 2);

        % Iterate through the matrix (Column array to row array)
        for i = squareMatrix(:)'
            if i <= 0 || i > rows^2 % Not in range, exit loop
                break;
            elseif numCheck(i) % Already marked true, repeated
                break;
            else
                numCheck(i) = true; % Mark it as true
            end
        end

        % if all is marked true then isMagicSquare remain true for now
        isMagicSquare = all(numCheck);

        % Now check the sum of rows, columns and diagnoals equal
        if isMagicSquare % If already false, then don't need the step

            % Sum array of all rows and columns
            sumRows = sum(squareMatrix,1);
            sumCols = sum(squareMatrix,2)'; % Column vector to row vector

            % Sum of two diagnoals
            sumDiags1 = 0;
            sumDiags2 = 0;
            for i = 1:rows
                sumDiags1 = sumDiags1 + squareMatrix(i,i);
                sumDiags2 = sumDiags2 + squareMatrix(rows-i+1, i);
            end

            % Check, in sequence:
            %   - Two diagnoals have the same sumRows
            %   - The row sums all equal to diagnoal sum
            %   - The column sums all equals to diagnoal sum
            if ~all([sumDiags1 == sumDiags2, sumRows == sumDiags1, sumCols == sumDiags1])
                isMagicSquare = false;
            end

        end
    end
end
