data = load("data/checkerboard.mat");
checkerboard = data.checkerboard;

mu = load("data/clusterCentroids.mat"); 
prototypes = mu.clusterCentroids;

epochs =[20,100,200,500];
n=100;% 100 prototypes
% xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2
xdim =1;
ydim =2;
figure();
for i= 1:length(epochs)
    subplot(2,2,i);
    pp = batchNG(checkerboard, 100, epochs(i), xdim, ydim);
    title("Epochs- "+ epochs(i));
    hold on;
end

%kmeans
%Plot the data points, the prototypes and the cluster boundaries for K-means clustering after termination. 
%Upload the plot

figure()
[mu,~,~] = kmeans(checkerboard,prototypes);
scatter(checkerboard(:,1),checkerboard(:,2),'bo');
hold on;
scatter(mu(:,1),mu(:,2),[],'MarkerFaceColor', 'r');
hold on;
voronoi(mu(:,1),mu(:,2));
title("Kmeans clustering");
