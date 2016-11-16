function [walkResultX, walkResultY] = random_walk(walkSteps)
%RANDOMWALK walk in random directions
%   RANDOMWALK(steps) walks in random directions. It starts from (0,0) and walk
%   for 1 unit distance for steps time. The sequence of x values and y values is
%   stored in two arrays, walkResultX and walkResultY.
%
%   RANDOM_WALK accepts the following inputs:
%       walkSteps - the number of steps to take
%
%   RANDOM_WALK has the following outputs:
%       walkResultX - The array of all the X coordinates
%       walkResultY - The array of all the Y coordinates
%
%   To plot a nice graph:
%       [a, b] = random_walk(steps);
%       plot(a, b)


    % Set initial coordinate to be 0
    x = 0;
    y = 0;

    % Initialize the arrays
    walkResultX = zeros(1, walkSteps);
    walkResultY = zeros(1, walkSteps);

    % Walk number of steps
    for i = 1 : walkSteps

        % Pick a random angle
        angle = rand * 2 * pi;

        % Calculate x and y components to move
        x = x + cos(angle);
        y = y + sin(angle);

        % Record the coordinates
        walkResultX(i) = x;
        walkResultY(i) = y;
    end
end
