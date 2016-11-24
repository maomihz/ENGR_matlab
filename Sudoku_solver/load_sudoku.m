function puzzles = load_sudoku(filename)
%LOAD_SUDOKU load sudoku puzzles from file

    % open the puzzle file
    puzzleFile = fopen(filename, 'r');

    % Initialize cell
    puzzles = {};
    puzzleCount = 1;

    % Read line by line
    while true
        line = fgetl(puzzleFile);

        if (~ischar(line)) % If reached end, then exit loop
            break;
        end

        % Ignore line length ~= 81
        if size(line, 2) == 81
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
            puzzles{puzzleCount} = puzzle;
            puzzleCount = puzzleCount + 1;
        end

    end
end
