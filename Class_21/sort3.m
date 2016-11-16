function [a,b,c] = sort3 (x,y,z)
%SORT3 sort 3 numbers
%   SORT3(x,y,z) sorts 3 numbers in descending order.
%
%   The function take 3 numbers as its arguments stored in x, y, z
%   and return 3 numbers a, b, c, and the first of which is the maximum value.

if (x > y)
    if (x > z)
        if (y > z)
            a = x;
            b = y;
            c = z;
        else % y < z
            a = x;
            b = z;
            c = y;
        end
    else % x < z
        a = z;
        b = x;
        c = y;
    end
else % x < y
    if (x > z)
        a = y;
        b = x;
        c = z;
    else % x < z
        if (y > z)
            a = y;
            b = z;
            c = x;
        else % y < z
            a = z;
            b = y;
            c = x;
        end
    end
end
