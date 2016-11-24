function result = verify_sudoku(sudokuPuzzle, ignoreEmpty)
%VERIFY_SUDOKU verify a sudoku puzzle is valid
%   VERIFY_SUDOKU(puzzle, ignoreEmpty) verifies if a sudoku board is valid or
%   not. If ignoreEmpty is set to true, then the puzzle can be incomplete,
%   and it tests whether it has any conflict on the board. If set to false,
%   only if the puzzle is complete and no conflict can the function return
%   true.
%
%   VERIFY_SUDOKU has the following inputs:
%       puzzle - the 9x9 puzzle to check
%       ignoreEmpty - whether test incomplete sudoku (true) or not (false).
%
%   VERIFY_SUDOKU has the following outputs:
%       result - (logical) whether it is valid or not

    if nargin < 1
        error('Argument number should be at least 1! ');
    elseif ~valid_sudoku(sudokuPuzzle)
        error('Input must be a valid sudoku board! ');
    else
        if nargin < 2 % IgnoreEmpty defaults to false
            ignoreEmpty = false;
        end

        result = true;
        for i = 1:9

            % Row and column not valid, exit loop
            if ~verify_row(sudokuPuzzle(i, :), ignoreEmpty) || ...
                ~verify_row(sudokuPuzzle(:, i)', ignoreEmpty)
                result = false;
                return;
            end

            % Extract the small box

            n = i - 1; % Make n range from 0-8
            rowfrom = floor(n / 3) * 3 + 1; % 1,1,1,4,4,4,7,7,7
            rowto = (floor(n / 3) + 1) * 3; % 3,3,3,6,6,6,9,9,9
            colfrom = mod(n, 3) * 3 + 1;    % 1,4,7,1,4,7,1,4,7
            colto = (mod(n, 3) + 1) * 3;    % 3,6,9,3,6,9,3,6,9

            smallBox = sudokuPuzzle(rowfrom:rowto, colfrom:colto);

            if ~verify_row(smallBox(:)', ignoreEmpty)
                result = false;
                return;
            end
        end

    end
end
