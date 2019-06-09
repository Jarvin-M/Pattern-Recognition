function [prototypes, prototypes_classes, relevances, relevances_trace, training_errors] = rlvq_train(X, y, n_prototypes, eta_weigths, eta_relevances, epochs)
    
    % compute the means for each class
    classes = unique(y);
    means = zeros(size(classes, 1), size(X, 2));
    for j = 1 : size(classes, 1)
        means(classes(j), :) = mean(X(y == classes(j), :));
    end
    
    prototypes_classes = zeros(sum(n_prototypes), 1) - 1;
    prototypes = zeros(sum(n_prototypes), size(X, 2));
    
    % intialize the prototypes
    current_position = 1;
    for n = 1 : length(n_prototypes)
        for j = 1 : n_prototypes(n)
            prototypes_classes(current_position) = classes(n);
            prototypes(current_position, :) = means(classes(n), :);
            current_position = current_position + 1;
        end
    end
 
    % initialize the relevances
    relevances = [0.5; 0.5];
    n_samples = size(X, 1);
    % training
    training_errors = zeros(epochs, 1);
    relevances_trace = zeros(epochs, size(X, 2));
    for epoch = 1 : epochs
        fprintf(" Epoch %d -> \n", epoch);
        
        % in each epoch, present all the examples
        for j = 1 : n_samples
            % take the closest prototype
            distances = pdist2(X(j, :), prototypes, 'mahalanobis', diag(relevances)) .^ 2;
            [~, i] = min(distances);
            psi = sign((prototypes_classes(i) == y(j)) - 0.5);
            prototypes(i, :) = prototypes(i, :) + eta_weigths * psi * (X(j, :) - prototypes(i, :));
            
            % update the relevances (and normalize sum to 1)
            relevances = relevances - eta_relevances * psi * (X(j, :) - prototypes(i, :))';
            relevances = relevances / sum(relevances);
        end
        
        % store the relevances
        relevances_trace(epoch, :) = relevances;
        
        % training error
        rlvq_label = rlvq_classify(X, prototypes, prototypes_classes, relevances);
        training_errors(epoch) = mean(y ~= rlvq_label);
        fprintf("Error = %.4f\n",  training_errors(epoch));
        
        % exit check
        if epoch > 50 && std(training_errors((epoch - 49) : epoch)) < 0.004
            break;
        end
    end
    
    relevances_trace = relevances_trace(1 : epoch, :);
    training_errors = training_errors(1 : epoch);
end
