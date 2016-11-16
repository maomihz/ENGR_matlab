%KAPREKAR_SUM compute sum of number of times to run kaprekar's routine to
%reach the kaprekar's constant from 0000 - 9999
%
%   the output is printed and stored in routeSum variable.

routeSum = 0;
for i = 0:9999
    routeSum = routeSum + kaprekar_iteration(i);
end
fprintf('Sum is: %d\n', routeSum);
