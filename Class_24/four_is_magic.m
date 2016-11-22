function [] = four_is_magic(num)
%FOUR_IS_MAGIC perform four is magic transformation
%   FOUR_IS_MAGIC(number) performs four is magic transformation. It depends on
%   num2word for number to word transformation.
%
%   FOUR_IS_MAGIC has the following inputs
%       num - number to perform four is magic
%
%   FOUR_IS_MAGIC has no outputs. It prints the result to terminal.

    while true
        % Transform to word
        word = strtrim(num2word(num));

        % Count number of letters in the word
        wordlen = size(find(isstrprop(word, 'alpha')), 2);

        % Print a sentense
        fprintf('%s is %d\n', word, wordlen)

        % Found 4 is magic
        if wordlen == 4
            break;
        end

        % Else, perform the next loop
        num = wordlen;
    end

    fprintf('four is magic!\n');
end
