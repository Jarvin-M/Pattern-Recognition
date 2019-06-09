
function labels = classify_lvq1(X, prototypes, prototypes_classes)

    % calculate the euclidena distance between points and prototypes
    distances = pdist2(X, prototypes, 'euclidean') .^ 2;
    % take out the minimum distances
    [~, indexes] = min(distances, [], 2);
    labels = prototypes_classes(indexes);

end