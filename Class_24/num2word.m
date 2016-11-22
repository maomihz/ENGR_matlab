function word = num2word(num)
%NUM2WORD turn number into english word
%   NUM2WORD(num) turns number into english word.
%   It supports number both positive and negative from 0 up to trillions.
%   For numbers more than trillions, it may not work properly.
%
%   NUM2WORD has the following inputs:
%       num - number to turn to word
%
%   NUM2WORD has the following outputs:
%       word - the english word

    % Truncate the number
    num = floor(num);

    WORD_LIST = {'zero','one','two','three','four','five','six','seven', ...
        'eight','nine','ten','eleven','twelve'};
    PREFIX_LIST = {'thir','four','fif','six','seven','eigh','nine'};
    if num < 0 % Negative
        word = ['negative ', num2word(-num)];
    elseif num <= 12 % 0 - 12
        word = WORD_LIST{num + 1};
    elseif num <= 19 % 13 - 19
        word = [PREFIX_LIST{num - 12}, 'teen'];
    elseif num <= 99 % 20 - 99

        if num >= 20 && num <= 29 % 20-29
            prefix = 'twenty';
        elseif num >= 40 && num <= 49
            prefix = 'forty';
        else % 30,40,50,...,90
            prefix = [PREFIX_LIST{floor(num / 10) - 2}, 'ty'];
        end

        if mod(num, 10) == 0 % 20, 30, ..., 90
            word = prefix;
        else % 21, 22, ...
            word = [prefix, ' ', num2word(mod(num, 10))];
        end
    else % >100
        PREFIX_LIST_2 = {'hundred','thousand','million','billion','trillion'};
        PREFIX_BOUNDARY = [2,3,6,9,12]; % Log 10 boundary

        boundary = floor(log10(num));
        count = find(boundary >= PREFIX_BOUNDARY, 1, 'last');

        b = 10^PREFIX_BOUNDARY(count);
        word = [num2word(floor(num / b)), ' ', PREFIX_LIST_2{count}];

        if mod(num, b) ~= 0 % not 1b,2b,3b...9b
            word = [word, ' ', num2word(mod(num, b))];
        end
    end

end
