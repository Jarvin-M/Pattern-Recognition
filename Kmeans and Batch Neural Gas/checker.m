%--------------------------
%6
%---------------------------
chek = load("data/checkerboard.mat"); % 3700 2D vectors
checkerboard = chek.checkerboard;

k =100;
tmax =20; % number of runs
series =10; % each series has 20 runs
each_serie =[];
for ser =1:series
    
    minDp =[]; % minimum quantization errors for Kmeans++
    minD =[]; % min quantization errors for kmean
    for i =1:tmax
        %kmeans plusplus=0 J is the quantization error
        disp("Series "+ ser +"/10 t = "+ i +"/20");
        [~,D, R] = quantization(checkerboard,k,0);
        %kmeans++ plusplus =1
        [~,Dp, Rp] = quantization(checkerboard,k,1);
        minDp = [minDp; min(Dp)];
        minD = [minD; min(D)];
    end
    each_serie = [each_serie; [min(minDp) min(minD)]];
end 

% mean of minimum q error for kmeans++
average_pp = mean(each_serie(:,1));
disp("mean for kmeans++ "+ average_pp);

%standard deviation for kmeans ++
std_pp = std(each_serie(:,1));
disp("Standard deviation for kmeans++ "+ std_pp);
% mean of minimum q error for kmeans
average_p = mean(each_serie(:,2));
disp("mean for kmeans++ "+ average_p);

%standard deviation for kmeans ++
std_p = std(each_serie(:,2));
disp("Standard deviation for kmeans "+ std_p);
%p-value using an unpaired one-tailed two-sample t-test
[h,p] = ttest2(each_serie(:,1),each_serie(:,2),'Vartype','unequal');
disp("P- value is "+ p);



