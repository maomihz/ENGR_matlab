function result = valid_sudoku(sudokuPuzzle)
%VALID_SUDOKU check if an sudoku puzzle sudoku is valid
%   VALID_SUDOKU(puzzle) checks if an sudoku puzzle is valid. A valid sudoku
%       puzzle is a 9x9 numerical array with values 0-9. 0 represents empty
%       space and known numbers are filled with 1-9.
%
%   An example of valid puzzle would be the following:
%       [0,9,0, 4,0,8, 0,0,7;
%        3,0,0, 7,9,0, 0,6,0;
%        0,0,5, 0,1,0, 0,0,0;
%
%        0,0,1, 0,0,0, 0,2,0;
%        2,4,8, 0,0,0, 1,9,6;
%        0,3,0, 0,0,0, 5,0,0;
%
%        0,0,0, 0,8,0, 3,0,0;
%        0,8,0, 0,2,7, 0,0,9;
%        7,0,0, 3,0,4, 0,8,0]

    if nargin ~= 1
        error('Argument number should be at least 1! ');
    end

    result = true;

    % Check it is an numeric matrix
    if ~isnumeric(sudokuPuzzle)
        result = false;

    % Check is 9x9 in size
    elseif size(sudokuPuzzle,1) ~= 9 || size(sudokuPuzzle,2) ~= 9
        result = false;

    % Check all elements is within range 0-9
    elseif ~all(sudokuPuzzle(:) >= 0) || ~all(sudokuPuzzle(:) <= 9)
        result = false;

    % Check all numbers are integer
    elseif ~all(floor(sudokuPuzzle(:)) == sudokuPuzzle(:))
        result = false;

    end

end
