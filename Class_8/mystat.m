% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      539
% Team:
% Assignment:   ICA 1
% Date:         6 Feburary 2017

function [] = mystat(vector_data)
    vector_data = vector_data(:);
    fprintf('Mean: %.2f\n', mean(vector_data));
    fprintf('Median: %.2f\n', median(vector_data));
    fprintf('Mode: %.4f\n', mode(vector_data));
    fprintf('Variance: %.3f\n', var(vector_data));
    fprintf('Standard Deviation: %.3f\n', std(vector_data));
    fprintf('Min: %.4f\n', min(vector_data));
    fprintf('Max: %.4f\n', max(vector_data));
    fprintf('Count: %d\n', length(vector_data));


end
