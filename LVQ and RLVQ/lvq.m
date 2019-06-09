
%Input
    %prototypes per class
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
    data = 
    %using euclidean distance measure
    
end
