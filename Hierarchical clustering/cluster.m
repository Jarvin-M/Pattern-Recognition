data = load('cluster_data.mat');
data = data.cluster_data;

dist = pdist(data);
dist = squareform(dist);

thresholds = [0.05 0.1 0.15 0.2 0.25];
figure();
for i=1:length(thresholds)
    subplot(2,3, i);
    scatter(data(:,1), data(:,2), 'b.');
    title(['threshold t < ' num2str(thresholds(i))]);
    hold on;
    [row,col] = find(dist<=thresholds(i));
    for ci=1:size(row,1)
        X = [data(row(ci), 1) data(col(ci), 1)];
        Y = [data(row(ci), 2) data(col(ci), 2)];
        line(X, Y, 'Color', 'k');
    end

end
hold off;

% Question 5
figure()
t=0.18;
scatter(data(:,1), data(:,2),'b.');
title(['Optimal threshold value t< ' num2str(t)]);
hold on;

[row,col] = find(dist<=t);
for i=1:size(row,1)
    X = [data(row(i), 1) data(col(i), 1)];
    Y = [data(row(i), 2) data(col(i), 2)];
    line(X, Y,'Color', 'k');
end
