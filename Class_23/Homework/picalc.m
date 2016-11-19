function summation = picalc(numberTerms)
%PICALC approximate the value of pi
%   PICALC(terms) is a very simple approximation of the ratio of a circle's
%   circumference to its diameter, pi.
%
%   It accepts the following arguments:
%       terms - accuracy of approximation. The larger the number is, the more
%           accurate result will the function get. Because the function involves
%           factorial, the number should not be greater than 170 because
%           factorial(171) exceeds the limit of double value.
%
%   It has the following outputs:
%       PI - approximated pi value

    % Initialize the variable
    summation = 0;

    % Starting from i to numberTerms
    for i = 0:numberTerms

        % Apply the function
        summation = summation + (factorial(i) / semifactorial(2 * i + 1));
    end

    summation = summation * 2;
end
