%TEST_INNER_PRODUCT tests of inner_product function

% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   Class 23 CFU(1)
% Date:         21 November 2016

% Test 1
testX = [16 28 28 4 29]; % Test Vector 1
testY = [28 14 24 4 12]; % Test Vector 2
expected = 1876; % Hand calculated Result
actual = inner_product(testX, testY);

fprintf('Executing Test 1 ...\n')

% Print the vectors
fprintf('Test Vector 1: [')
for i = 1:5
    fprintf('%d', testX(i));
    if (i < 5)
        fprintf(',');
    else
        fprintf('];\n');
    end
end

fprintf('Test Vector 2: [')
for i = 1:5
    fprintf('%d', testY(i));
    if (i < 5)
        fprintf(',');
    else
        fprintf('];\n');
    end
end

% Print expected and actual
fprintf('Expected Result: %d\n', expected);
fprintf('Actual: %d\n', actual);

% Compare expected and actual
if expected == actual
    fprintf('Test 1 Passed! \n');
else
    fprintf('Test 1 Failed. \n');
end


fprintf('\n'); % Extra line between tests


% Test 2
% Length of test vector (random between 2 - 12)
testLen = floor(rand * 10 + 3);

% Generate values (0 - 49)
for i = 1:testLen
    testX(i) = floor(rand * 50);
    testY(i) = floor(rand * 50);
end

% Calculate expected using built-in dot() method
expected = dot(testX, testY);
actual = inner_product(testX, testY);

% Print the vectors
fprintf('Executing Test 2 ...\n');
fprintf('Test Vector 1: [')
for i = 1:testLen
    fprintf('%d', testX(i));
    if (i < testLen)
        fprintf(',');
    else
        fprintf('];\n');
    end
end

fprintf('Test Vector 2: [')
for i = 1:testLen
    fprintf('%d', testY(i));
    if (i < testLen)
        fprintf(',');
    else
        fprintf('];\n');
    end
end

% Print expected and actual
fprintf('Expected Result: %d\n', expected);
fprintf('Actual: %d\n', actual);

% Compare expected and actual
if expected == actual
    fprintf('Test 2 Passed! \n');
else
    fprintf('Test 2 Failed. \n');
end
