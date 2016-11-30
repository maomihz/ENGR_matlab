function [numLines, numWords, numChars] = wc(fileName)
%WC word count program
%   WC(fileName) counts the number of lines, words and characters in a file.
%   The file is specified as name in argument.
%
%   WC has the following inputs:
%       fileName - (String) The name of the file. Name should be a file's path
%           including suffix. Either absolute or relative path is accepted.
%           When specifing relative path, make sure the file is in the current
%           working directory, otherwise an error would be thrown.
%
%   WC has the following outputs:
%       numLines - Number of Lines in the file
%       numWords - Number of Words in the file. A word is some combination of
%           letters and punctuations surrounded by either white space, start
%           of a line or end of a line.
%       numChars - Number of characters in the file. Newline characters would
%           not count.
%

    % open the file
    if exist(fileName, 'file')
        fid = fopen(fileName, 'r');
    else
        error([ 'File does not exist! Check the path is correct and file ', ...
            'is in the current working directory. ']);
    end

    % Initialize counter
    numLines = 0;
    numWords = 0;
    numChars = 0;

    while true

        % Read one line
        line = fgetl(fid);

        % If reached end of file, exit loop
        if ~ischar(line)
            break;
        end

        % Increment number of lines
        numLines = numLines + 1;

        % Increment number of chars
        numChars = numChars + length(line);

        % Count the words

        % Remove leading and trailing spaces
        line = strtrim(line);

        % For an empty line
        if isempty(line)
            continue;
        end

        % Find the position of all spaces
        spaceIdx = find(isspace(line));

        % If there is no space, then there is only one word
        if isempty(spaceIdx)
            numWords = numWords + 1;
            continue;
        end

        % Number of words = number of non-consecutive spaces + 1
        % Example: 'Madam I am  Adam!'
        % spaceIdx --> [6, 8, 11, 12]
        % spaceIdxDiff --> [2, 3, 1]
        % spaceCount --> 2 (We ignore 1's because only if the space is
        %   consecutive can there be difference of 1)
        % Count the number of words in a line, exactly 2 + 2 = 4.
        spaceIdxDiff = diff(spaceIdx);
        spaceCount = length(find(spaceIdxDiff ~= 1));
        numWords = numWords + spaceCount + 2;
    end

    % Close the file
    fclose(fid);

end
