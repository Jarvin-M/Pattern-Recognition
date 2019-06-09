A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

X = [A; B];
y = [ones(length(A), 1); ones(length(B), 1) * 2];

% creating folds for the data
n = 10;
folds = zeros(size(X, 1), n);
for i = 1 : n
    folds(:, i) = (1 + mod((1 : size(X, 1))', n)) ~= i;
end

% compute the test error for each split
validation_errors = zeros(n, 1);
for i = 1 : n
    mask = logical(folds(:, i));
    % training and validation set
    X_train = X(mask', :);
    y_train = y(mask);
    X_val = X(~mask, :);
    y_val = y(~mask);
    
    fprintf('\n');
    fprintf(' Fold %d -> \n', i);
    % train(n = 0.01, max_epochs = 500)
    [prototypes, prototypes_classes, ~] = train_lvq1(X_train, y_train, [2; 1], 0.01, 500);
    
    % validation
    y_predicted = classify_lvq1(X_val, prototypes, prototypes_classes);
    errors(i) = mean(y_predicted ~= y_val);
end

% mean test error
average_error = mean(errors)*100;

% plot
figure;
bar(errors*100);
title('Test Error(10-fold cross-validation)');
xlabel('k-fold');
ylabel('Test Error in (%)');
hold on;
plot(xlim, [average_error average_error], 'r');
hold off;
