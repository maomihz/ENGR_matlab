
function [] = simplestat(vector_data)
    len = length(vector_data)
    vector_data = vector_data(1:5:end)
    
    fprintf('Mean: %f\n', mean(vector_data));
    fprintf('Median: %f\n', median(vector_data));
    fprintf('Mode: %f\n', mode(vector_data));
    fprintf('Variance: %f\n', var(vector_data));
    fprintf('Standard Deviation: %f\n', std(vector_data));
    fprintf('Standard Deviation: %f\n', std(vector_data));
    fprintf('Min: %f\n', min(vector_data));
    fprintf('Max: %f\n', max(vector_data));
    fprintf('Count: %d\n', len);

end
