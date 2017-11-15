% Read the data
data = xlsread('soapbox.xlsx');

% Plot histogram
figure(1)
histogram(data(:, 2), 98.5:1:105.5);
xlabel('Mass (oz)');
ylabel('Sample Count');
title('Soapbox Histogram');

% Analyze data
data_mean = mean(data(:, 2));
data_std = std(data(:, 2), 1);

fprintf('Mean: %f\n', data_mean);
fprintf('Standard Deviation: %f\n', data_std);

fprintf('P(between 101 and 102 oz) = %f\n', normcdf(102, data_mean, data_std) - normcdf(101, data_mean, data_std));
fprintf('P(> 104 oz) = %f\n', 1 - normcdf(104, data_mean, data_std));
fprintf('P(< 100 oz) = %f\n', normcdf(100, data_mean, data_std));

% Trial and error
guess_min = 80;
guess_max = 120;
threshold = 0.0001;

guess_diff = guess_max - guess_min;
while guess_diff > threshold
    guess = (guess_max + guess_min) / 2;
    guess_diff = guess - guess_min;
    cdf = normcdf(guess, data_mean, data_std);
    if cdf > 0.95
        guess_max = guess;
    else
        guess_min = guess;
    end
end

fprintf('This box weight exceeded only 5%%: %f\n', guess);
