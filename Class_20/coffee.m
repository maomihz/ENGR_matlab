%COFFEE computes the cost when you order from a coffee shop
%   COFFEE is a simple calculator to calculate the cost.
%
%   Cost consists of $10.50 per pound + cost of shipping,
%   which is $0.86 per pound plus flat fee $1.50.
%
%   COFFEE asks the user for number of pounds and print
%   the total cost of an order.
%
%   COFFEE overwrites these variables:
%       fee - total cost of the order
%

% constants
COFFEE_PER_POUND = 10.5;
SHIPPING_PER_POUND = 0.86;
SHIPPING_FEE = 1.50;

% input
pounds = input('Type number of pounds ==> ');

% Processing
fee = (COFFEE_PER_POUND + SHIPPING_PER_POUND) * pounds + SHIPPING_FEE;

% output
fprintf('Hey, your order costs $%.2f! Have a great day!\n',fee);
