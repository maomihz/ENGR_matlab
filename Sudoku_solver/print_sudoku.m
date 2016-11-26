function [] = print_sudoku(sudokuPuzzle)
%PRINT_SUDOKU print a sudoku puzzle to terminal
%   PRINT_SUDOKU(sudokuPuzzle) prints a sudoku puzzle to terminal.
%   Empty spaces are represented by .
%
%   Example:
%    +-------+-------+-------+
%    | 5 3 4 | 6 7 8 | 9 1 2 |
%    | 6 7 2 | 1 9 5 | 3 4 8 |
%    | 1 9 8 | 3 4 2 | 5 6 7 |
%    +-------+-------+-------+
%    | 8 5 9 | 7 6 1 | 4 2 3 |
%    | 4 2 6 | 8 5 3 | 7 9 1 |
%    | 7 1 3 | 9 2 4 | 8 5 6 |
%    +-------+-------+-------+
%    | 9 6 1 | 5 3 7 | 2 8 4 |
%    | 2 8 7 | 4 1 9 | 6 3 5 |
%    | 3 4 5 | 2 8 6 | 1 7 9 |
%    +-------+-------+-------+

    if nargin ~= 1
        error('Argument number should be at least 1! ');

    % If invalid puzzle matrix then throw an error
    elseif (~valid_sudoku(sudokuPuzzle))
        error('Input is not valid sudoku puzzle! ');
    end

    % Iterate through the puzzle
    fprintf('+-------+-------+-------+\n'); % The first line
    for i = 1:9 % i = for each row

        fprintf('| '); % Left boundary

        for j = 1:9 % j = for each element in a row

            num = sudokuPuzzle(i,j);

            if num == 0
                c = '.'; % Print .
            else
                c = num2str(num); % Print Number
            end
            fprintf('%s ', c);

            % Middle vertical lines
            if mod(j, 3) == 0
                fprintf('| ');
            end
        end
        fprintf('\n');

        % middle horizontal lines
        if mod(i, 3) == 0
            fprintf('+-------+-------+-------+\n');
        end
    end


end
