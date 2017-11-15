%CIRCUIT plot the circuit data

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 4
% Date:         30 January 2017

f = linspace(60, 110, 60);
R = linspace(10, 40, 60);

% f = 60:110;
% R = 10:40;

w = 2 * pi * f;

[x, y] = meshgrid(w, R);
z = 24 ./ sqrt(y .^ 2 + (x * 240e-3 - 1 ./ (x * 15e-6)) .^ 2);

figure(1);
mesh(x, y, z);
xlabel('w (angular frequency)');
ylabel('R (Ohms)');
zlabel('I (Amps)');

figure(2);
contour(x, z, y);
xlabel('w (angular frequency)');
ylabel('I (Amps)');
