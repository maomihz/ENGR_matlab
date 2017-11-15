% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 2
% Date:         6 Feburary 2017

load('normtemp_data.txt');

temperature = normtemp_data(:, 1);
sex = normtemp_data(:, 2);
age = normtemp_data(:, 3);

figure(1);

histogram(temperature, 12);
xlabel('Tempurature');
ylabel('Frequency');
title('Temperature for Adult Males and Females');

figure(2);
histogram(temperature(1:5:end), 12);


mystat(temperature(1:5:end));
fprintf('--- --- --- ---');
mystat(age);
