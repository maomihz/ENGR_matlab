% MYUTILITY my awesome utility!
%
% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 2
% Date:         20 Feburary 2017

load('SomeUtility.mat');

% Create arrays
failurelen = length(failures);
xvals = zeros(1, failurelen);
yvals = zeros(1, failurelen);

% Iterate through the values
for i = 1:length(failures)
    xvals(i) = failures(i).x;
    yvals(i) = failures(i).y;
    failures(i).distance = sqrt(failures(i).x ^ 2 + failures(i).y ^ 2);
end

% Sort
[d, indexes] = sort([failures.distance]);
sorted_failures = failures(indexes);

fprintf('Maximum distance is %.2f with worker %s.\n', sorted_failures(failurelen).distance, sorted_failures(failurelen).LineWorker);

% Plot
figure('Name','Failure Locations Plot','NumberTitle','off');
plot(xvals, yvals, 'ob');
title('Failure Locations');
xlabel('X');
ylabel('Y');
