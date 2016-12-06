function [] = censor(fileToCensor, fileBannedWords)
%CENSOR censor a text file
%   CENSOR(fileToCensor, fileBannedWords) censors a text file.
%
%   If only one argument fileToCensor is given, the program runs in mode 1.
%   In mode 1, it censors all four-letter words. in the file.
%       A word is only censored if it is a valid word and it contains four
%       letters (See the definition of a word).
%
%   If the second optional argument fileBannedWords is given, the program runs
%       in mode 2.
%   In mode 2, fileBannedWords specifies the list of words to censor. All
%       occurance of any word from the word list would be censored no matter
%       it is a seperate word or not. Which means there can be part of a word
%       censored.
%
%
%   "To censor" means to replace the letters in an instance of a word (or words)
%       as * (asterisks)
%
%   A "Word" is defined as a group of English letters (Uppercase or lowercase,
%       including dash - and apostrophe ') seperated by non-letter and non-digit
%       characters, start of a line or end of a line. If a dash (-) or
%       an apostrophe (') have a non-letter in either left or right index
%       (including start of a line or end of a line) then they are
%       also regarded as a seperator, otherwise it would be considered a part
%       of the word.
%   A word is invalid if there is at least one occurance of a digit, or more
%       than one occurance of apostrophe, or mix of apostrophe and dash,
%       or consecutive apostrophe or dash.
%
%   Example:
%        - That's a line containing -four- word-of-the-year ---- 'doesn't',
%            'make', 'any' and 'sense'.
%       The sentence is seperated into "That's", "a", "line", "containing",
%           "four", "word-of-the-year", "doesn't", "make", "any", "sense".
%
%   CENSOR has the following inputs:
%       fileToCensor - the file to censor. The program will not modify the
%           original file, it would write to a new file instead, and rename
%           the file to {OriginalName}_censored.{OriginalSuffix}. The number
%           of characters in the file would not be altered. Output file would
%           be silently overwritten.
%       fileBannedWords - (Optional) the banned words list. The argument
%           switch the program to run in mode 2. Instead of censoring 4-letter
%           words by default, the words to censor is read from the file. The
%           file contains words one word a line, and the whole line together
%           is treated as a word regardless of any presence of special
%           characters/spaces. Leading and trailing spaces and end of lines are
%           ignored. Words appear early in the list has more precedence than the
%           later.
%
%   CENSOR has no outputs. The output is written into a file.


    %% Argument Check
    % Check both file specified by argument exist
    if ~exist(fileToCensor, 'file') || ...
        (nargin >= 2 && ~exist(fileBannedWords, 'file'))
        error('Input file does not exist! ');
    end

    %% Constant Declaration
    % A-Za-z0-9 -'
    LETTERS = [abs('A'):abs('Z'), abs('a'):abs('z'), abs('0'):abs('9')];

    %% Compute the output file name
    % Find the slash position
    slashIdx = find(fileToCensor == '/', 1, 'last');
    if isempty(slashIdx)
        slashIdx = 0;
    end

    % Seperate directory name and base name
    dirName = fileToCensor(1:slashIdx);
    baseName = fileToCensor(slashIdx + 1:end);

    % Find the position of suffix seperator '.'
    suffixIdx = find(baseName == '.', 1, 'last');
    if isempty(suffixIdx)
        suffixIdx = length(baseName) + 1;
    end

    % Seperate the suffix
    suffix = baseName(suffixIdx:end);

    % Rename the new file to write
    fileToWrite = [dirName, baseName(1:suffixIdx - 1), '_censored', suffix];

    %% Open files for read and write
    fileToCensorId = fopen(fileToCensor, 'r');
    fileToWriteId = fopen(fileToWrite, 'w');

    %% Censorship
    % Censor 4 letter word mode
    if nargin < 2
        while true
            % Read one line
            line = fgetl(fileToCensorId);

            if ~ischar(line)
                break;
            end

            wordStartIdx = 1;
            lineLength = length(line);

            % Iterate through all characters in one line.
            % wordStartIdx keep tracks the position of last letter immediately
            % after a non-letter. If wordIdx encounters a non-letter or end of
            % line, it evaluates whether wordStartIdx + 1 to wordEndIndex - 1
            % is 4 characters. If so, censor the word.
            for wordEndIdx = 1:lineLength + 1
                % The condition for being a seperator: (either)
                % - current index is EOL
                % - current index is non-(letter+apostrophe+dash)
                % - current index is (apostrophe+dash) AND
                %       not surrounded by letters)
                if wordEndIdx > lineLength || ...
                    ~ismember(line(wordEndIdx), [LETTERS, '''-']) || ...
                    ( ...
                        ismember(line(wordEndIdx), '''-') && ...
                        ( ...
                            (wordEndIdx - 1 < 1 || ~ismember(line(wordEndIdx - 1), LETTERS)) || ...
                            (wordEndIdx + 1 > lineLength || ~ismember(line(wordEndIdx + 1), LETTERS)) ...
                        ) ...
                    )

                    % *** Conditions to decide whether the word is valid ***
                    toCensor = true;
                    wordToCensor = line(wordStartIdx:wordEndIdx - 1);

                    % CONDITION: must be 4 letters
                    if (wordEndIdx - wordStartIdx) ~= 4
                        toCensor = false;
                    end

                    % CONDITION: must not contain numbers
                    if toCensor && any(isstrprop(wordToCensor, 'digit'))
                        toCensor = false;
                    end

                    % CONDITION: must not start with or end with an -
                    if toCensor && (wordToCensor(1) == '-' || wordToCensor(end) == '-')
                        toCensor = false;
                    end

                    % CONDITION: must not start with an '
                    if toCensor && wordToCensor(1) == ''''
                        toCensor = false;
                    end

                    % CONDITION: must not be more than one (- or ')
                    % Example:
                    %   - What's: to censor
                    %   - ----: not censor
                    if toCensor && sum(wordToCensor == '-' | wordToCensor == '''') >= 2
                        toCensor = false;
                    end


                    % Censor the word
                    if toCensor
                        line(wordStartIdx:wordEndIdx - 1) = '*';
                    end

                    % Reset wordStartIdx
                    wordStartIdx = wordEndIdx + 1;
                end
            end

            % Write the censored line into file
            fprintf(fileToWriteId, '%s\n', line);
        end
    else % Custom censor mode

        % Read a list of words, split by lines
        bannedWordsListId = fopen(fileBannedWords, 'r');
        wordsList = split(fread(bannedWordsListId, '*char')', sprintf('\n'));

        while true
            % Read one line
            line = fgetl(fileToCensorId);

            if ~ischar(line)
                break;
            end

            wordStartIdx = 1;
            lineLength = length(line);

            % wordStartIdx keeps track of the index of the last character of
            % last censored word + 1 (Except the initial value)
            for wordEndIdx = 1:lineLength

                for i = 1:length(wordsList)
                    wordsList{i} = strtrim(wordsList{i});
                    % Ignore Empty words
                    if isempty(wordsList{i})
                        continue;
                    end
                    bannedWordLength = length(wordsList{i});

                    % Extract word from (wordEndIndex - length + 1) to wordEndIndex.
                    % if (all of the following)
                    %  - wordStartIdx to wordEndIdx be at least equal to the length of the extracted word
                    %  - (wordEndIndex - length + 1) to wordEndIndex is equal the banned word
                    if wordEndIdx - wordStartIdx + 1 >= bannedWordLength && ...
                        strcmpi(line(wordEndIdx - bannedWordLength + 1:wordEndIdx), wordsList{i})

                        line(wordEndIdx - bannedWordLength + 1: wordEndIdx) = '*';
                        wordStartIdx = wordEndIdx + 1;
                    end
                end
            end

            fprintf(fileToWriteId, '%s\n', line);
        end % End of custom mode, reading file

        fclose(bannedWordsListId);

    end % End of mode selection

    %% Close files
    fclose(fileToWriteId);
    fclose(fileToCensorId);


end
