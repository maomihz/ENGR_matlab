%STRESS plot the stress strain data

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 2
% Date:         30 January 2017

data = load('Steel.txt');
d_position = data(:, 1);
d_time = data(:, 3);
d_stress = data(:, 4);
d_strain = data(:, 2) * 100;

subplot(2,2,1);
plot(d_strain, d_stress);
xlabel('Strain (%)');
ylabel('Stress (mPa)');

subplot(2,2,2);
plot(d_time, d_position);
xlabel('time (sec)');
ylabel('displacement distance (mm)');

subplot(2,2,3);
plot(d_position, d_strain);
xlabel('displacement distance (mm)');
ylabel('Strain (%)');

subplot(2,2,4);
plot(d_time, d_stress);
xlabel('time (sec)');
ylabel('Stress (mPa)');
