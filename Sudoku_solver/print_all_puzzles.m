%PRINT_ALL_PUZZLES solve all sudoku in a file
%   PRINT_ALL_PUZZLES solves all sudoku puzzles in one file.

% Uncomment to select one puzzle file
% FILE = 'puzzles/easy.txt';
% FILE = 'puzzles/simple.txt';
% FILE = 'puzzles/intermediate.txt';
FILE = 'puzzles/hard.txt';
% FILE = 'puzzles/custom.txt';
% FILE = 'puzzles/proj_euler.txt';

PRINT_ORIGINAL = true; % Printing unsolved puzzle
VERIFY_SOLUTION = true;
TIMING = true; % Printing time elapsed


puzzles = load_sudoku(FILE);

count = 1;

% Iterate through all puzzles
for i = puzzles
    % Start timer
    tic;

    % run solver
    solution = solve_sudoku(i{1});

    % Print solution puzzle
    fprintf('Puzzle #%d: \n', count);
    if PRINT_ORIGINAL
        print_sudoku(i{1});
    end
    print_sudoku(solution);

    % Verify the solution
    if VERIFY_SOLUTION
        if verify_sudoku(solution)
            fprintf('Solution Verified. ');
        else
            fprintf('Solution Incorrect. ');
        end
    else
        fprintf('\n');
    end

    % Stop timer
    tElapsed = toc;
    if TIMING
        fprintf('Time elapsed: %.6f seconds\n', tElapsed);
    end
    count = count + 1;
end
