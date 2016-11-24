%PRINT_ALL_PUZZLES solve all sudoku in a file

puzzles = load_sudoku('hard.txt');

c = 1;
for i = puzzles
    solution = solve_sudoku(i{1});
    fprintf('%d: \n', c);
    print_sudoku(solution);

    if verify_sudoku(solution)
        fprintf('SOLVED!!!\n');
    else
        fprintf('Not really...\n');
    end
    c = c + 1;
end
