function ciphertext = caesar(plaintext, shiftValue)
%CAESAR encrypt string using caesar's algorithm
%   CAESAR(plaintext, key) encrypts string using caesar's algorithm, given the
%   key. Only alphabetical letters are encrypted and are converted to uppercase
%   letters, and others are left alone.
%
%   CAESAR accepts the following inputs:
%       plaintext - (String) The plaintext to encrypt
%       key - (Tnteger) Encryption key. Non-integer would be silently truncated.
%
%   CAESAR has the following outputs:
%       ciphertext - Encrypted text

    % Silently truncate non integer for the key
    shiftValue = floor(shiftValue);

    % Convert plaintext to uppercase
    plaintext = upper(plaintext);

    % Iteration for each character in the plaintext
    for i = 1:length(plaintext)

        % Get the character in that position
        character = plaintext(i);

        % If the character is a letter
        if isstrprop(character, 'alpha')

            % Convert the character into a number
            codepoint = abs(character);

            % Codepoint for letter 'A' is 65 so convert all the character codepoint
            % to 0~25 so that it is easier to work with
            tmpCodepoint = codepoint - 65;

            % Shift the code and if greater than 25, shift back
            tmpCodepoint = mod(tmpCodepoint + shiftValue, 26);

            % Convert back character code point and modify the character
            % in the original string
            plaintext(i) = char(tmpCodepoint + 65);
        end
    end

    % Now plaintext is processed and become ciphertext
    ciphertext = plaintext;

end
