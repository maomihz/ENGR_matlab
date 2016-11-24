function result = verify_row(array, ignoreEmpty)
%VERIFY_ROW verifies a row vector contains all and only values from 1 to N
%   VERIFY_ROW(array, ignoreEmpty) verifys a row vector contaols all and only
%   values from 1 to N, where N is the length of array. But if the "IgnoreEmpty"
%   flag is set to "True", then it only tests if there is any repetition within
%   range, ignore any 0s.
%
%   Example:
%       - verify_row([3,2,6,1,5,4], false) --> true (Contain all and only 1-6)
%       - verify_row([1,4,0,0,0,0], true) --> true (No repetition, ignore 0)
%
%   VERIFY_ROW has the following arguments:
%       array - the row array to verify_row
%       ignoreEmpty - whether to ignore empty (marked as 0)
%
%   VERIFY_ROW has the following outputs:
%       result - the result of verification

    % The length of the row array
    len = size(array, 2);

    % Initialize a false array
    numCheck = false(1, len);

    result = true;
    % Iterate through array elements
    for i = array
        if i < 0 || i > len % Not in range, exit loop
            result = false;
            break;
        elseif i ~= 0
            if numCheck(i) % Already marked
                result = false;
                break;
            end
            numCheck(i) = true; % mark to true
        end
    end

    % not ignoreEmpty requires all and only number in 1-N
    if ~ignoreEmpty
        result = all(numCheck);
    end

end
