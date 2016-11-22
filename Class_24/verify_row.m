function result = verify_row(array)
%VERIFY_ROW verifies a row vector contains all and only values from 1 to N

    % The length of the row array
    len = size(array, 2);

    % Initialize a false array
    numCheck = false(1, len);

    % Iterate through array elements
    for i = array
        if i <= 0 || i > len % Not in range, exit loop
            break;
        elseif numCheck(i) % Already marked, exit loop
            break;
        else
            numCheck(i) = true; % mark to true
        end
    end

    result = all(numCheck);

end
