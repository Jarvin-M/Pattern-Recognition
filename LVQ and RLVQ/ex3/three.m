A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% creating X and y
X = [A; B];

% label 1 corresponds to class A and label 2 corresponds to class B
y = [ones(length(A), 1); ones(length(B), 1) * 2];

% plotting
figure;
colors = [0 0 1; 1 0 0];

% training
n_prototypes = [2; 1];
[prototypes, prototypes_classes, relevances, relevances_trace, validation_errors] = rlvq_train(X, y, n_prototypes, 0.01, 0.001, 500);

% plot the feature space
feature_space = gscatter(prototypes(:, 1), prototypes(:, 2), prototypes_classes, [0 0 1; 1 0 0], '^o', 16, 'off');
for n = 1 : length(feature_space)
    set(feature_space(n), 'MarkerFaceColor', colors(n, :));
end

hold on;
gscatter(X(:, 1), X(:, 2), y, [0.5 0.5 1; 1 0.5 0.5], '^o');
hold off;
title('Dataset');
xlabel('Feature 1');
ylabel('Feature 2');

% plot the training errors
figure;
subplot(2, 1, 1);
plot(validation_errors);
title('Training Error');
xlabel('Epoch');
ylabel('Training Error');

% variation of relevances with epochs
subplot(2, 1, 2);
plot(relevances_trace);
title('Features Relevances');
xlabel('Epoch');
ylabel('Relevance');
legend({'Feature 1', 'Feature 2'});

% cross validation
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
    
    % training
    [prototypes, prototypes_classes, relevances, relevances_trace, ~] = rlvq_train(X_train, y_train, n_prototypes, 0.01, 0.001, 500);
    
    % validation
    y_predicted = rlvq_classify(X_val, prototypes, prototypes_classes, relevances);
    validation_errors(i) = mean(y_predicted ~= y_val);
end

% average test error
average_error = mean(validation_errors)*100;

% plot
figure;
bar(validation_errors*100);
title('Test Error(10-fold cross-validation)');
xlabel('k-fold');
ylabel('Test Error in (%)');
hold on;
plot(xlim, [average_error average_error], 'r');
hold off;

