function [ ] = draw_text_balloon(inputText, maxWidth)
%DRAW_TEXT_BALLOON draw a text balloon
%   DRAW_TEXT_BALLOON draws a text balloon intelligently.
%
%   The function take in two arguments, the text, and line width, and
%   wraps the text around a balloon at about maxWidth columns, and print it.

    tmpText = inputText; % Give a temporary value
    textArray = repmat(' ', 10, maxWidth); % Initialize character matrix (size 10)
    lineCount = 1; % count the number of lines

    while(size(tmpText, 2) > maxWidth)
        % make a slice of the text of MAXWIDTH characters
        textSlice = tmpText(1:maxWidth);

        % initialize "this" line
        thisLine = blanks(maxWidth);

        % find the position of last space in the text slice
        lastSpacePos = find(isspace(textSlice),1,'last');

        % empty means there is no space in the slice
        if (isempty(lastSpacePos))
            lastSpacePos = maxWidth;
        end

        % fill in the blanks
        thisLine(1:lastSpacePos) = textSlice(1:lastSpacePos);

        % remove portion from the original string
        tmpText(1:lastSpacePos) = '';

        textArray(lineCount, 1:end) = thisLine; % record the processed line

        % Dynamically expand array for efficiency
        if (size(textArray, 1) <= lineCount)
            newArray = repmat(' ',lineCount + 10, maxWidth);
            newArray(1:lineCount, 1:end) = textArray(1:end, 1:end);
            textArray = newArray;
        end

        lineCount = lineCount + 1;   % increment counter

    end

    % now the remaining text must be <MAXWIDTH characters
    textArray(lineCount, 1:end) = [tmpText, blanks(maxWidth - size(tmpText, 2))];


    % find the width of the whole text to make it beautiful
    textWidth = 0;
    for i = 1:lineCount
        lineText = strtrim(textArray(i, 1:end));
        textWidth = max(textWidth, size(lineText, 2));
    end

    % print the top line according to width
    fprintf([' ', repmat('_',1,textWidth + 2), '\n']);


    for i = 1:lineCount
        if (lineCount == 1)
            fprintf('< '); % Only one line, print <
        elseif (i == 1)
            fprintf('/ '); % The first line, print /
        elseif (i == lineCount)
            fprintf('\\ '); % The last line, print \
        else
            fprintf('| '); % Middle lines, print |
        end

        fprintf(textArray(i, 1:textWidth)); % Print the actual text

        if (lineCount == 1)
            fprintf(' >\n'); % Only one line, print >
        elseif (i == 1)
            fprintf(' \\\n'); % First line, print \
        elseif (i == lineCount)
            fprintf(' /\n'); % Last line, print /
        else
            fprintf(' | \n'); % Middle lines, print |
        end
    end

    % print the bottom line
    fprintf([' ', repmat('-',1,textWidth + 2), '\n']);

end
