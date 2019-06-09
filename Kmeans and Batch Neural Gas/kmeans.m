function [mu,all_means,closest] = kmeans(feature_vectors,prototypes)
%input
%2D array - feature vectors
% k 

%Initialize the k means as k distinct points randomly chosen from the dataset.
%Euclidean distance
%Stop criterion is none of tha data points are reassigned


%==========================================
%Kmeans Clustering Algorithm
%===========================================
mu = prototypes; 
previous =0;
all_means(:,:,1) = mu;

while ~isequal(closest,last)
    previous = mu;
%     closest = [];
%     for i =1:length(feature_vectors(:,1))
%         dist = sqrt(sum((feature_vectors(i,:) - mu).^2,2));  
%         
%         closest(end+1) = find(dist == min(dist));
%     end
    [~,closest] = pdist2(mu, feature_vectors, 'euclidean', 'Smallest', 1);
    %Update the prototypes
    for xi = 1:length(mu(:,1))
        dat = feature_vectors(closest == xi,:); % return data belonging to a certain prototypes
        mu(xi,:)= mean(dat);
        
    end
    
    all_means(:,:,end+1) =  mu; % adding the new prototypes
end
end
