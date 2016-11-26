%PRINT_ALL_PUZZLES solve all sudoku in a file
%   PRINT_ALL_PUZZLES solves all sudoku puzzles in one file.

% Uncomment to select one puzzle file
% FILE = 'easy.txt';
% FILE = 'simple.txt';
% FILE = 'intermediate.txt';
% FILE = 'hard.txt';
FILE = 'custom.txt';


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
    print_sudoku(solution);

    % Verify the solution
    if verify_sudoku(solution)
        fprintf('Solution Verified. ');
    else
        fprintf('Solution Incorrect. ');
    end

    % Stop timer
    tElapsed = toc;
    fprintf('Time elapsed: %.6f seconds\n', tElapsed)
    count = count + 1;
end
