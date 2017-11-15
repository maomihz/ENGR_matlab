function sum = my_sum(arr)
%MY_SUM calculate the sum of an array
%   MY_SUM(arr) calculates the sum of an array (Row matrix). The input array is
%   specified as an argument and the sum is returned.

    sum = 0;
    for i = 1:size(arr, 2)
        sum = sum + arr(i);
    end

end
