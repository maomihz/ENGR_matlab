function result = semifactorial(n)
%SEMIFACTORIAL compute the semifactorial of given number n
%   SEMIFACTORIAL(N) computes the semifactorial of the given number N.
%
%   It accepts the following inputs:
%       N - the number to compute
%
%   It has the following outputs:
%       result - semifactorial of N

    % Silently truncate input number n
    n = floor(n);

    if n > 0 % Greater than 0
        result = prod(n:-2:1);
    elseif n < 0 % Less than 0, error
        fprintf(2, 'N must be non-negative integers. ');
        result = -1;
    else % Equal to 0
        result = 1;
    end

end
