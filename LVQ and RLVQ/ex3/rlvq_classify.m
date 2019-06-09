function y = rlvq_classify(X, prototypes, prototypes_classes, relevances)

    distances = pdist2(X, prototypes, 'mahalanobis', diag(relevances)) .^ 2;
    [~, indexes] = min(distances, [], 2);
    y = prototypes_classes(indexes);
end
