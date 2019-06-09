function [prototypes, prototypes_classes, errors] = train_lvq1(X, y, n_prototypes, eta, max_epochs)
   
    % compute the means for the different classes
    classes = unique(y);
    means = zeros(size(classes, 1), size(X, 2));
    for j = 1 : size(classes, 1)
        means(classes(j), :) = mean(X(y == classes(j), :));
    end
    
    prototypes_classes = zeros(sum(n_prototypes), 1) - 1;
    prototypes = zeros(sum(n_prototypes), size(X, 2));
    
    % initialize the prototypes
    current_position = 1;
    for n = 1 : length(n_prototypes)
        for j = 1 : n_prototypes(n)
            prototypes_classes(current_position) = classes(n);
            prototypes(current_position, :) = means(classes(n), :);
            current_position = current_position + 1;
        end
    end
    
    n_samples = size(X, 1);
    % training
    training_errors = zeros(max_epochs, 1);
    for epoch = 1 : max_epochs
        fprintf(" Epoch %d -> \n", epoch);
        for j = 1 : n_samples
            % for each example and it's corresponding label
            distances = pdist2(X(j, :), prototypes, 'squaredeuclidean');
            [~, i] = min(distances);
            psi = sign((prototypes_classes(i) == y(j)) - 0.5);
            prototypes(i, :) = prototypes(i, :) + eta * psi * (X(j, :) - prototypes(i, :));
        end
        % compute the training error
        lvq1_label = classify_lvq1(X, prototypes, prototypes_classes);
        training_errors(epoch) = mean(y ~= lvq1_label);
        fprintf("Training error = %.4f\n",  training_errors(epoch));
        % stopping criteria(using 100 epochs as stability epochs and 0.004 as stability threshold)
        if epoch > 50 && std(training_errors((epoch - 49) : epoch)) < 0.004
            break;
        end
    end
    
    errors = training_errors(1 : epoch);
end