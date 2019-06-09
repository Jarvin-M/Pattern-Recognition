function prototypes = get_prototypes(feature_vectors,k,plusplus)
%PROTOTYPES Summary of this function goes here
%   Detailed explanation goes here
% ==============================
%Finding intial prototypes
%===============================
%choose random data point as first prototype
if plusplus == 1 % kmeans++ prototype selection
    
    random_index = randi(length(feature_vectors(:,1)));  % return random row index
    prototypes = feature_vectors(random_index,1:2);

    while (k-1)
        %For each data point x, compute D(x), the distance between x and the nearest prototype.

        D =[]; % array of min distances
        for i =1:length(feature_vectors(:,1))

            eucli = sqrt(sum((feature_vectors(i,:)-prototypes).^2,2));  
            D(end+1) = min(eucli);
        end

        proba = D.^2;
        newprototype_index = randsample(1:size(feature_vectors,1),1,true,proba);

        prototypes(end+1,:) = feature_vectors(newprototype_index,:);
        k = k-1;
    end
    
else % for standard kmeans
    prototypes = feature_vectors(randperm(length(feature_vectors), k), :);
end


end

