function puzzles = load_sudoku(filename)
%LOAD_SUDOKU load sudoku puzzles from file
%   LOAD_SUDOKU(filename) loads sudoku from a file. In the file, each puzzle is
%   represented by one line with 81 numbers. Empty space can be represented
%   by either '0' or '.'. Lines that is not a valid puzzle line would be
%   ignored. A cell of puzzles in one file would be returned.
%
%   LOAD_SUDOKU has the following inputs:
%       filename - the name of the file to loads
%
%   LOAD_SUDOKU has the following outputs:
%       puzzles - (cell) a list of puzzles represented by 2D array

    % open the puzzle file
    puzzleFile = fopen(filename, 'r');

    % Initialize cell
    puzzles = cell(0);
    puzzleCount = 1;

    % Read line by line
    while true
        line = fgetl(puzzleFile);

        if (~ischar(line)) % If reached end, then exit loop
            break;
        end

        % Ignore line length ~= 81
        if size(line, 2) == 81
            % Create an empty puzzle board
            puzzle = zeros(9,9);
            for i = 1:81
                c = line(i); % Read each character

                if c == '.'
                    n = 0;
                else
                    n = str2double(c);
                end

                puzzle(ceil(i / 9), mod(i - 1, 9) + 1) = n;
            end

            % Add the loaded puzzle into list of puzzles
            puzzles{puzzleCount} = puzzle;
            puzzleCount = puzzleCount + 1;
        end

    end
end
