function [outputArg1,outputArg2] = lvqq(prototypes,data)
%Input
    %prototypes per class with column showing which class they belong to
    %data
%Ouput
    %training error curve 

%Implement the LVQ1 algorithm with eta equals 0.01. 

%Use the squared Euclidean norm to determine the winner. 

%After each epoch, determine the number of misclassified training examples. 

%The training error E is defined as the number of misclassified training examples divided by 
%the total number of data points presented in the epoch. 

%Stop training when E becomes approximately constant.
%Check from which class the data points belong

eta = 0.01; %learning rate
epoch =1;
misclassified =[];
training_error = length(misclassified) / datapoints;
%epoch loop
while epoch
    %Go through all the data points
    for i = length(data(:,1))
        data_point = data(i, :);
        % euclidean distance between all prototypes
        eucli = sqrt(sum((data_point(1:2)-prototypes(:,1:2)).^2,2)); 
        
        %find the minimum distance
        min_index = find(eucli == min(eucli));
        %compare classes of min_index and data_point
        comparator = isequal(data_point(end), prototype(min_index,end));
        
        if comparator % if true
            
        else
            
        end
        %find the one with the smallest distance
            
         
    %using euclidean distance measure
    end
end

end

