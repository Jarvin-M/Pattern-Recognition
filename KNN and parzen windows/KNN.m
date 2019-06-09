function class = knn(point, K, data, class_labels)
    class_labels = class_labels(:); 
    euclidean_distances = sqrt(sum((data - point).^2, 2));
    % disp(euclidean_distances);
    neighbors_sorted = sortrows([euclidean_distances, class_labels]);
    % disp(neighbors_sorted);
    n_classes = length(unique(class_labels));
    % disp(n_classes);

    % now what we want to do is create an array
    % index is class and the value stored is the count
    % we take the index with max count as our class
    % for that point

    count_per_class = zeros(n_classes, 1);

    % mind that final class will be the class with maximum count 
    % index - 1(as matlab doesn't allow indexing starting from 0)
    for class = 1:n_classes
        count_per_class(class, 1) = sum(neighbors_sorted(1:K, 2) == (class - 1));
    end

    [~, final_index] = max(count_per_class);
    % disp('Count per class');
    % disp(count_per_class);
    class = final_index - 1;
end