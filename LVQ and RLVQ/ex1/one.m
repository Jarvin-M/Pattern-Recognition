A = importdata('data_lvq_A.mat');
B = importdata('data_lvq_B.mat');

% creating X and y
X = [A; B];

% label 1 corresponds to class A and label 2 corresponds to class B
y = [ones(length(A), 1); ones(length(B), 1) * 2];

% scatter plot
figure, hold on, grid on;
scatter(A(:,1), A(:,2), 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b', 'DisplayName', 'Class A');
scatter(B(:,1), B(:,2), 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'DisplayName', 'Class B');
title('Scatter Plot of the Dataset');
xlabel('Feature 1');
ylabel('Feature 2');
saveas(gcf, 'scatter', 'png');

combined = figure;
title('Training error using all four combinations of prototypes');
xlabel('Number of Epochs');
ylabel('Training error = # misclassifications / # examples');

six = figure;
% all the prototypes combinations which we need to account for
prototypes_comb = [1, 1; 1, 2; 2, 1; 2, 2];

for n = 1:size(prototypes_comb, 1)
    prototype = prototypes_comb(n, :);
    [prototypes, p_classes, errors] = train_lvq1(X, y, prototype, 0.01, 500);
   
    % plot training error for each of these prototype combination
    figure;
    plot(errors);
    title(sprintf('Training Error using %s prototype combination', mat2str(prototype)));
    xlabel('Epoch');
    ylabel('Training Error = # misclassifications / # examples');
    
    figure(combined);
    hold on;
    box on;
    plot(errors, 'DisplayName', mat2str(prototype));
    legend;
    hold off;
    
    colors = [0 0 1; 1 0 0];
    
    figure(six);
    subplot(2, 2, n);
    h_six = gscatter(prototypes(:, 1), prototypes(:, 2), p_classes, [0 0 1; 1 0 0], '^o', 8, 'off');
    for n = 1 : length(h_six)
        set(h_six(n), 'MarkerFaceColor', colors(n, :))
    end
    hold on;
    labels = classify_lvq1(X, prototypes, p_classes);
    gscatter(X(:, 1), X(:, 2), labels, [0.5 0.5 1; 1 0.5 0.5], '^o', 4);
    hold off;
    title(sprintf('Classification using %s combination of prototypes', mat2str(prototype)));
    xlabel('Feature 1');
    ylabel('Feature 2');
end




