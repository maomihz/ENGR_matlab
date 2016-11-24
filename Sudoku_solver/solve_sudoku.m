function [solution,solvable] = solve_sudoku(puzzle)
%SOLVE_SUDOKU solve sudoku puzzle

    if nargin ~= 1
        error('Argument number should be at least 1! ');
    elseif ~valid_sudoku(puzzle)
        error('Input must be a valid sudoku board! ');
    else

        possibilities = cell(9);
        progress = true; % Keep track, if there is no progress on solving
                         % then puzzle is unsolvable

        while progress

            % First assume it does not make progress
            progress = false;

            % Start of Basic Method
            for row = 1:9
                for col = 1:9

                    % (row, col) Not solved
                    if puzzle(row, col) == 0

                        % First extract the small box, because row and column number
                        % is already given as row and col
                        rowfrom = (ceil(row / 3) - 1) * 3 + 1;
                        rowto = ceil(row / 3) * 3;
                        colfrom = (ceil(col / 3) - 1) * 3 + 1;
                        colto = ceil(col / 3) * 3;
                        box = puzzle(rowfrom:rowto, colfrom:colto);

                        % Now for the row, col, box it contains, find the possibilities
                        % It always refresh possibility from start, not care previous one
                        filledValues = [puzzle(row, :), puzzle(:, col)', box(:)'];
                        pos = true(1,9);
                        for i = filledValues
                            if i ~= 0 && pos(i)
                                pos(i) = false;
                            end
                        end
                        possibilities{row, col} = find(pos);
                    else % reset already filled position's possibility to none
                        possibilities{row, col} = [];
                    end
                end
            end

            for row = 1:9
                for col = 1:9
                    % Only one possibilities here
                    if size(possibilities{row, col}, 2) == 1
                        puzzle(row, col) = possibilities{row, col};
                        progress = true; % We made progress!
                    end
                end
            end
            % End of Basic Method


            % At this stage, if the puzzle is in conflict, we know the puzzle
            % is not solvable.
            if ~verify_sudoku(puzzle, true)
                solution = puzzle;
                solvable = false;
                return;
            end


            % Start of Trial and Error Method
            if ~progress
                for row = 1:9
                    for col = 1:9
                        % Get a list of possibilities
                        p = possibilities{row, col};
                        % More than one possibilities here
                        % Then there must be a correct one amoung possibilities
                        if size(p, 2) > 1
                            for possibility = p

                                % try to solve with one possibility
                                puzzle(row, col) = possibility;
                                s1 = solve_sudoku(puzzle);

                                if verify_sudoku(s1) % If successfully solved, exit function
                                    solution = s1;
                                    solvable = true;
                                    return
                                end
                                % If not, just make another try.

                            end

                            % Because there must be one correct answer amoung
                            % All the possibilities. So if this line is reached,
                            % all possibilities tried, and no solution found.
                            % So the puzzle is not solvable.
                            solution = puzzle;
                            solvable = false;
                            return;
                        end
                    end
                end
            end
            % End of Trial and Error method

        end % End of big loop.
        % If this line is reached, then puzzle must be solved using the
        % first method.
        solution = puzzle;
        solvable = true;
    end


end
