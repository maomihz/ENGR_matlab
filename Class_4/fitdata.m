%FITDATA plot the fitdata
%
%   FITDATA plots the fitdata. It loads data from file fitdata.mat and plot it.
%
% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 1
% Date:         30 January 2017

data = load('fitdata.mat');

hold on
plot(data.x, data.y, 'ok');
% scatter(data.x, data.y, 'ok');
plot(data.x, data.yfit, 'k', 'LineWidth', 2);
plot(data.x, data.yfit + 0.3, '--r', 'LineWidth', 2);
plot(data.x, data.yfit - 0.3, '--r', 'LineWidth', 2);
hold off

xlabel('x data');
ylabel('y data and fit');

legend('Data', 'Fit', 'Lower/Upper Bounds');
