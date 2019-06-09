
feature_vector = [ 4 6 8 7 4; 5 3 7 4 6; 6 9 3 8 5];

% mean of each feature
means =[];
number_of_rows = length(feature_vector(:,1));
for row=1 : number_of_rows
    selected_feature = feature_vector(row,:);
    mean_of_feature = sum(selected_feature)/length(selected_feature);
    disp("Mean of feature "+ row +": "+mean_of_feature);
    means = [means; mean_of_feature];
end

%Biased covariance matrix
all_combinations = unique(nchoosek(repmat([1 2 3],1,2),2), "rows"); % combinations of rows and columns, i and j
number_measurements = length(feature_vector); % N
covariance_matrix = zeros(number_of_rows,number_of_rows);

for comb=1: length(all_combinations)
    ij = all_combinations(comb,:); 
    i = ij(1,1);
    j = ij(1,2);
    summation =0;
    for n=1: number_measurements
        
        eqn = (feature_vector(i,n)-means(i))* (feature_vector(j,n)-means(j));
        summation = summation + eqn;
    end
    
    
    %eqn = sym((feature_vector(i,n)-means(i))* (feature_vector(j,n)-means(j)));
    covaria = summation / number_measurements; % biased covariance
    covariance_matrix(j,i) = covaria;
    
end

disp("Covariance Matrix");
disp(covariance_matrix);

% question 14 -16
mvnpdf([5 5 6], means', covariance_matrix)

mvnpdf([3 5 7], means', covariance_matrix)

mvnpdf([4 6.5 1], means', covariance_matrix)
