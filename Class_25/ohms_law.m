%OHMS_LAW graph Ohm's Law
%   OHMS_LAW makes a proper plot for Ohm's Law. It graphs for two resistance
%   values and current range from 2A to 20A.

% Set resistance values
RESISTANCE_1 = 9;
RESISTANCE_2 = 19;

% Set current values
currentVals = 2:2:20;

% Calculate voltage values
voltageVals1 = currentVals * RESISTANCE_1;
voltageVals2 = currentVals * RESISTANCE_2;

% Prepare to plot the graph
figure(1);

% Add labels
title('Ohm''s Law for Two Resistance Values');
xlabel('Current (A)');
ylabel('Voltage (V)');

% Make Plots
plot(currentVals, voltageVals1, '-m'); % Solid, Megenta
hold on
plot(currentVals, voltageVals2, '--b'); % Dashed, Blue
hold off

% Add Legends
legend('9 Ohms','19 Ohms');
