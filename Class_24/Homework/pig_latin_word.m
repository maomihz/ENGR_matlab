function piglatin = pig_latin_word(word)
%PIG_LATIN_WORD transform a word into pig latin
%   PIG_LATIN_WORD(word) transforms a word into pig latin.
%
%   PIG_LATIN_WORD has the following inputs:
%       word - the word to transform. Whitespace around the word would be
%           deleted, and the word should not include any non-letter characters,
%           including punctuation, and an error would be thrown otherwise.
%
%   PIG_LATIN_WORD has the following outputs:
%       piglatin - the transformed word in pig latin

    VOWELS = 'aAeEiIoOuU'; % set of vowel

    % Remove white spaces
    word = strtrim(word);

    % Check the word is valid
    if ~all(isstrprop(word, 'alpha'))
        error('Input is not a valid word! ');
    end

    % If the word is empty, do nothing.
    if isempty(word)
        piglatin = '';
        return
    end

    % Find the position of vowel
    vowelPos = find(ismember(word, VOWELS), 1);

    % If no vowel find in the word
    if isempty(vowelPos)
        piglatin = [word, 'ay'];
    else
        % Otherwise, the new word is formed as:
        % vowel-end | 1-(vowel-1) | ay
        piglatin = [word(vowelPos:end), word(1:vowelPos-1), 'ay'];
    end



end
