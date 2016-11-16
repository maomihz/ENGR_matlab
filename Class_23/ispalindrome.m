function isPalindrome = ispalindrome(str)
%ISPALINDROME test if a string is a palindrome
%   ISPALINDROME(str) tests if a string is a palindrome. A palindrome is a
%       string, which is the same forwards and backwards. An example of this
%       would be "Madam, I'm Adam". Numbers, punctuation, whitespace and
%       capitalization are ignored.
%
%   ISPALINDROME has following inputs:
%       str - the string to test
%
%   ISPALINDROME has following outputs:
%       isPalindrome - (Logical) if the string is a palindrome

    % validate input is a string
    if ischar(str)
        % Strip all punctuation and numbers and convert to lowercase
        filteredStr = lower(str(isstrprop(str, 'alpha')));

        % The index of "Middle" Character
        middlePos = floor(length(filteredStr) / 2);

        % Seperate the initial half and second half
        % Second half is reversed in order
        firstHalf = filteredStr(1:middlePos);
        secondHalf = filteredStr(end:-1:end-middlePos+1);

        % Compare the two halves
        isPalindrome = strcmp(firstHalf, secondHalf);
    else
        % Input is not a string
        fprintf(2, 'WARNING: Input is not a string!\n');
        isPalindrome = false;
    end

end
