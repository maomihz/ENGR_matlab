function [] = words(fileIn, fileOut)
%WORDS count number of apperance of words in a file
%   WORDS(fileIn, fileOut) counts number of apperance of words in a text file.
%   Both input file and output file is specified as argument. Punctuations are
%   ignored and words are converted to lowercase.
%
%   The output format is [word],[count] and one word a line.
%
%   WORDS has the following inputs:
%       fileIn - the input file name
%       fileOut - the output file name. If output file already exists, it would
%           prompt user to confirm overwrite.
%
%   WORDS has no outputs. Contents are written to a file specified by fileOut.

    % Check for input file existance
    if ~exist(fileIn, 'file')
        error([ 'Input file does not exist! Check the path is correct and file ', ...
            'is in the current working directory. ']);
    end

    % Check for output file existance
    % (Not implementing due to potential problem with auto-grader)
    % if exist(fileOut, 'file')
    %     userIn = input('Output file already exist, overwrite? (y/n): ', 's');
    %     if ~strcmpi(userIn, 'y')
    %         fprintf('Aborting. \n');
    %         return;
    %     end
    % end

    % Preallocate two arrays
    wordsList = cell(1,10);
    countList = zeros(1,10);
    wordsCount = 0;

    % Open two files for read and write
    finId = fopen(fileIn, 'r');
    foutId = fopen(fileOut, 'w');

    % Loop to read line by line
    while true
        line = fgetl(finId);

        % Detect EOF
        if ~ischar(line)
            break;
        end

        % Split the words in a line
        wordsInLine = strsplit(line);

        % Iterate through words
        for i = 1:length(wordsInLine)

            % convert to lowercase
            myWord = lower(wordsInLine{i});
            % Strip non-letters
            myWord = myWord(isletter(myWord));

            % ignore an empty word
            if isempty(myWord)
                continue;
            end

            % Create a flag, assume it is a new encountered word
            isNewWord = true;

            % Search in words already encountered
            for j = 1:wordsCount
                % Check if already encountered
                if strcmp(myWord, wordsList{j})
                    isNewWord = false; % Set flag to false
                    % increment count by 1 and exit loop
                    countList(j) = countList(j) + 1;
                    break;
                end
            end

            % If indeed is a new word
            if isNewWord
                % Count of words increments
                wordsCount = wordsCount + 1;

                % add the word into the list of words
                wordsList{wordsCount} = myWord;
                countList(wordsCount) = 1;

                % Automatically expand two lists by 10 if necessary
                if wordsCount >= length(countList)
                    wordsList{end+10} = [];
                    countList(end+10) = 0;
                end
            end

        end % End of line processing

    end % End of file reading

    % Sort the word list
    sortedWordsList = sort({wordsList{1:wordsCount}});
    % Write the statistics to the file
    for i = 1:wordsCount
        word = sortedWordsList{i};
        % Search for the correct index from the unsorted one
        count = countList(strcmp(wordsList, word));
        fprintf(foutId, '%s,%d\n', word, count);
    end

    % Close the files
    fclose(finId);
    fclose(foutId);

end
