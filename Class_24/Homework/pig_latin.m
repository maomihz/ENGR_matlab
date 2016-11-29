function piglatin = pig_latin(sentence)
%PIG_LATIN transform sentence into pig latin
%   PIG_LATIN(sentence) transforms a sentence into pig latin.
%
%   Pig Latin is a language game in which words in English are altered. The
%   objective is to conceal the words from others not familiar with the rules.
%
%   PIG_LATIN has the following inputs:
%       sentence - the sentence to transform. It must not include any
%           non-letter characters, including punctuation, and an error
%           would be thrown otherwise.
%
%    PIG_LATIN has the following outputs:
%       piglatin - the transformed sentence in piglatin
%

    % Split the sentence
    words = strsplit(sentence);

    % Transform each word into pig latin
    for i = 1:length(words)
        words{i} = pig_latin_word(words{i});
    end

    % Join the transformed words into sentence
    piglatin = strjoin(words);

end
