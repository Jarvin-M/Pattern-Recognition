function [J,D, R] = quantization(feature_vectors,kmax,plusplus)
%QUANTIZATION Summary of this function goes here
%   Detailed explanation goes here
% Input
% K =1,2,3,...kmax
% kmax less than number of points in the dataset
% d number of dimensions

% Output
% R is the reference function - R(k)=J(1)k^(-2/d)
% D(k)=R(k)/J(k)
% J - quantization error as a function of k. J(1)=R(1) for k=1
d =2;

J = zeros(kmax,1);
R = zeros(kmax,1);
D = zeros(kmax,1);

if(kmax < length(feature_vectors(:,1))) % check if kmax is less than total number of data points
    for ki=1:kmax
        prototypes = get_prototypes(feature_vectors,ki,plusplus);
        [mu,~,closest] = kmeans(feature_vectors,prototypes);
        J(ki) = 0;
        for xi = 1:length(mu(:,1))
            dat = feature_vectors(closest == xi,:);
            eucli = sum((dat - mu(xi,:)).^2,2);
            J(ki) = J(ki) +( 0.5 * sum(eucli));
        end
        % R(k)=J(1)k^(-2/d)
        R(ki) = J(1)* ki^(-2/d);
        %D(k)=R(k)/J(k)
        D(ki) = R(ki)/ J(ki);
    end
   
end %end if

end

