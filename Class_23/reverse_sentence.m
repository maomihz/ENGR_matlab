function reversedSentence = reverse_sentence(sentence)
%REVERSE_SENTENCE reverse the words in a sentence
%   REVERSE_SENTENCE(sentence) reverse the words in a sentence. It seperate the
%   sentence by white spaces and return the reversed sentence. It does not
%   detect punctuations and will blindly be reversed.
%
%   REVERSE_SENTENCE accepts the following arguments:
%       sentence - (String) the sentence to reverse
%
%   REVERSE_SENTENCE has the following outputs:
%       reversedSentence - the sentence that is reversed

    % Split the sentence at whitespace
    wordArray = strsplit(sentence);

    % Reverse the words sequence
    reverseArray = fliplr(wordArray);

    % join the sequence back
    reversedSentence = strjoin(reverseArray);

end
