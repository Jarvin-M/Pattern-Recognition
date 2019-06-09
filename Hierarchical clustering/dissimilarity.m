X = importdata('provinces.mat');
X = zscore(X);
Y = pdist(X,'Euclidean');
D = squareform(Y);

city = {"South Holland","North Holland","Utrecht","Limburg","North Brabant","Gelderland","Overijssel","Flevoland","Groningen","Zeeland", "Friesland","Drenthe"};
%Groningen is row 9
Groni = D(9,:);
minval = min(Groni(Groni >0));
min_index = find(Groni == minval);
disp("Most similar city is "+ city(min_index) + " with dissimilarity value " + minval);

maxval = max(Groni(Groni >0));
max_index = find(Groni == maxval);
disp("Least similar city is "+ city(max_index) + " with dissimilarity value " + maxval);
