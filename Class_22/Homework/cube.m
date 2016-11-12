function [ ] = cube(sideLength)
%CUBE draw a 3D cube
%   CUBE(sideLength) draws a 2D representation of a cube.
%
%   CUBE accept the following arguments:
%       sideLength - (integer) length of the sides of the cube. If it's not an
%           integer, the decimal part would be silently truncated. The program
%           works best when sideLength is an even number.
%
%   CUBE does not have any return values. Picture of the cube is printed.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class22 Homework3 Cube
% Date:         11 November 2016

    % Truncate
    sideLength = floor(sideLength);

    if (sideLength > 0)
        % Calculate horizontal, vertical, diagonal length
        horizontal = sideLength * 2;
        vertical = sideLength;
        diagonal = floor(sideLength / 2); % If odd number


        % Initialize vertex list. There would be 7 vertices in a cube picture, and
        % they are numbered from 1-7 like this:
        % 1----2      To refer row number of a vertex: (number, 1)
        % |\    \     To refer column number of a vertex: (number, 2)
        % | 3----4
        % 5 |    |    Example: vertex 3's row number: vertex(3,1), which is 3.
        %  \|    |
        %   6----7
        %
        vertex = zeros(7,2);

        % Vertex 1. Always on (1,1)
        % In the following program I will refer to specific vertex only by number.
        vertex(1,1) = 1;
        vertex(1,2) = 1;

        % 1 --> 2
        % Row number is the same.
        % Column Number is (1's column) + horizontal + 1.
        vertex(2,1) = vertex(1,1);
        vertex(2,2) = vertex(1,2) + 1 + horizontal;

        % 1 --> 3
        % Row number is (1's row) + diagonal + 1.
        % Column Number is (1's column) + diagonal + 1.
        vertex(3,1) = vertex(1,1) + 1 + diagonal;
        vertex(3,2) = vertex(1,2) + 1 + diagonal;

        % 3 --> 4
        % Same as 1 --> 2.
        vertex(4,1) = vertex(3,1);
        vertex(4,2) = vertex(3,2) + 1 + horizontal;

        % 1 --> 5
        % Row number is (1's row) + vertical.
        % Column Number is the same.
        vertex(5,1) = vertex(1,1) + 1 + vertical;
        vertex(5,2) = vertex(1,2);

        % 5 --> 6
        % Same as 1 --> 3.
        % 5 lies on the same column as 3.
        vertex(6,1) = vertex(5,1) + 1 + diagonal;
        vertex(6,2) = vertex(3,2);

        % 7 lies on the same row as 6.
        % 7 lies on the same column as 4.
        vertex(7,1) = vertex(6,1);
        vertex(7,2) = vertex(4,2);

        % initialize an empty canvas
        canvas = repmat(' ', vertex(7,1), vertex(7,2));

        % Draw all vertices
        for i = 1:size(vertex, 1)
            canvas(vertex(i, 1), vertex(i, 2)) = '+';
        end

        % Draw all horizontal lines.
        % 1 --> 2, 3 --> 4, 6 --> 7
        for i = 1 : horizontal
            canvas(vertex(1,1), vertex(1,2) + i) = '-';
            canvas(vertex(3,1), vertex(3,2) + i) = '-';
            canvas(vertex(6,1), vertex(6,2) + i) = '-';
        end

        % Draw all vertical lines.
        % 1 --> 5, 3 --> 6, 4 --> 7
        for i = 1 : vertical
            canvas(vertex(1,1) + i, vertex(1,2)) = '|';
            canvas(vertex(3,1) + i, vertex(3,2)) = '|';
            canvas(vertex(4,1) + i, vertex(4,2)) = '|';
        end

        % Draw all diagonal lines.
        % 1 --> 3, 2 --> 4, 5 --> 6
        for i = 1 : diagonal
            canvas(vertex(1,1) + i, vertex(1,2) + i) = '\';
            canvas(vertex(5,1) + i, vertex(5,2) + i) = '\';
            canvas(vertex(2,1) + i, vertex(2,2) + i) = '\';
        end

        % Print the canvas
        for i = 1:size(canvas, 1)
            for j = 1:size(canvas, 2)
                fprintf('%s', canvas(i, j));
            end
            fprintf('\n');
        end

    else
        fprintf(2, 'Cube side length should >0. Aborting. \n');
    end

end
