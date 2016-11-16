function isPalindrome = ispalindrome2(str)
%ISPALINDROME2 alternate method to test if a string is a palindrome
%   ISPALINDROME2(str) is an alternate method to test if a string is a
%       palindrome. A palindrome is a string, which is the same forwards and
%       backwards. An example of this would be "Madam, I'm Adam". Numbers,
%       punctuation, whitespace and capitalization are ignored.
%
%   ISPALINDROME2 has following inputs:
%       str - the string to test
%
%   ISPALINDROME2 has following outputs:
%       isPalindrome - (Logical) if the string is a palindrome

    % validate input is a string
    if ischar(str)
        % Strip all punctuation and numbers and convert to lowercase
        filteredStr = lower(str(isstrprop(str, 'alpha')));

        % The index of "Middle" Character
        middlePos = floor(length(filteredStr) / 2);

        % Assume the string is a palindrome
        isPalindrome = true;

        % Iterate from two ends and compare character one by one
        for i = 1:middlePos
            % One character does not match
            if filteredStr(i) ~= filteredStr(end-i+1)
                isPalindrome = false;
                break; % Exit the loop
            end
        end
    else
        % Input is not a string
        fprintf(2, 'WARNING: Input is not a string!\n');
        isPalindrome = false;
    end

end
