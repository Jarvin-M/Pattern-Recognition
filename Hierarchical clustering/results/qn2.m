data = load('cluster_data.mat');
data = data.cluster_data;

clustering = {'single', 'complete','average'};
for i =1:length(clustering)
    Z = linkage(data,clustering{i}, 'euclidean');
    c = cluster(Z,'maxclust',4);
    
    figure()
    scatter(data(:,1),data(:,2),[],c);
    title("Clusters and Centroids " + clustering{i} + " linkage");
    hold on;
    %plotting centroids
    for ci=1:4
        cluster_data = data(c==ci,:);
        centroid = mean(cluster_data);
        plot(centroid(1), centroid(2),'ko','MarkerFaceColor','k');
    end
    hold off;
    
    figure();
    cutoff = median([Z(end-2,3) Z(end-1,3)]);
    dendrogram(Z,'ColorThreshold',cutoff)
    title(clustering{i}+ " Dendrogram");
    
end

% average linkage dendrogram
% Z = linkage(data,'complete');
% c = cluster(Z,'maxclust',4);
% 