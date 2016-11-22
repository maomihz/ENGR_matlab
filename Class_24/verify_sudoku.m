function result = verify_sudoku(sudokuPuzzle)
%VERIFY_SUDOKU verify a sudoku solution is valid
%   VERIFY_SUDOKU(puzzle) verifies if a sudoku board is valid or not.
%
%   VERIFY_SUDOKU has the following inputs:
%       puzzle - the 9x9 puzzle to check
%
%   VERIFY_SUDOKU has the following outputs:
%       result - (logical) whether it is valid or not

    if nargin ~= 1
        error('Argument number should be at least 1! ');
    elseif ~isnumeric(sudokuPuzzle)
        error('Input must be an numeric sudoku board! ');
    elseif size(sudokuPuzzle,1) ~= 9 || size(sudokuPuzzle,2) ~= 9
        error('Input must be a sudoku board! ');
    else
        result = true;
        for i = 1:9
            % Verify rows
            if ~verify_row(sudokuPuzzle(i, :))
                result = false;
                break;
            end

            % Verify columns
            if ~verify_row(sudokuPuzzle(:, i)')
                result = false;
                break;
            end

            n = i - 1; % Make n range from 0-8
            rowfrom = floor(n / 3) * 3 + 1; % 1,1,1,4,4,4,7,7,7
            rowto = (floor(n / 3) + 1) * 3; % 3,3,3,6,6,6,9,9,9
            colfrom = mod(n, 3) * 3 + 1;    % 1,4,7,1,4,7,1,4,7
            colto = (mod(n, 3) + 1) * 3;    % 3,6,9,3,6,9,3,6,9

            % Extract the small box
            smallBox = sudokuPuzzle(rowfrom:rowto, colfrom:colto);

            if ~verify_row(smallBox(:)')
                result = false;
                break;
            end
        end

    end
end
