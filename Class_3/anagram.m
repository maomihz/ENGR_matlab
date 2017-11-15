function isAnagram = anagram(word1, word2)
%ISANAGRAM compare two words to see if they are anagram
%   ISANAGRAM(word1, word2) compares two words to see if they are anagram.
%
%   Anagram is a word or phrase formed by rearranging the letters of another
%   word or phrase. Case doesn't matter and white space don't count.
%
%   ISANAGRAM has the following inputs:
%       word1 - the first word
%       word2 - the second word
%
%   ISANAGRAM has the following results:
%       result - whether they are anagram or not

    isAnagram = strcmp(sort(lower(word1(isletter(word1)))), sort(lower(word2(isletter(word2)))));
end
