function [] = print_sudoku(sudokuPuzzle)
%SUDOKU_PRINT(puzzle) print a sudoku puzzle to terminal

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
