% 3 dimensional data sampled from two categories
load1 = load('lab3_3_cat1.mat');
cat1 = load1.x_w1;

load2 = load('lab3_3_cat2.mat');
cat2 = load2.x_w2;

load3 = load('lab3_3_cat3.mat');
cat3 = load3.x_w3;

%parzen windows ia speherical gaussian
h =2; % Length of the edge of the hypercube
vol = (h * sqrt(2*pi)) ^3; % volume of the spherical parzen 
n = 10; % numebr of data points

u = [0.5; 1.0; 0.0];
v = [0.31; 1.51; -0.5];
w = [ -1.7; -1.7; -1.7];

densities = [];

X =[u v w];
pointnames = [ "u", "v", "w"];

for Xx =1 :length(X(1,:))
    dens =[];
    % Class 1
    gaus1 =0;
    for x=1 : n
        gaus11 = -sum((X(:,Xx)'- cat1(x,:)).^2);
        omega = exp( gaus11 /( 2*(h^2)));
        gaus1 = gaus1 +omega;
    end
    
    density = gaus1 /(vol * n);
    dens = [dens; density];
    disp("Class 1 - point "+ pointnames(Xx) +" density: "+ density)
    
    % Class 2
    gaus2 =0;
    for x=1 : n
        gaus22 = -sum((X(:,Xx)'- cat2(x,:)).^2);
        omega2 = exp( gaus22 / (2*(h^2)));
        gaus2 = gaus2 +omega2;
    end
    
    density2 = gaus2 /(vol * n);
    dens = [dens; density2];
    disp("Class 2 - point "+ pointnames(Xx) +" density: "+ density2)
    
    % Class 3
    gaus3 =0;
    for x=1 : n
        gaus33 = - sum((X(:,Xx)'- cat3(x,:)).^2);
        omega3 = exp( gaus33 / (2*(h^2)));
        gaus3 = gaus3 +omega3;
    end
    
    density3 = gaus3 /(vol * n);
    dens = [dens; density3];
    disp("Class 3 - point "+ pointnames(Xx) +" density: "+ density3)
    densities = [densities dens];
end



%Priors
total_observations = length(cat1)+length(cat2)+length(cat3);
%prior category 1
prior_cat1 = length(cat1) /total_observations;
%prior category 2
prior_cat2 = length(cat2) /total_observations;
%prior category 3
prior_cat3 = length(cat3) /total_observations;

prior_matrix = [prior_cat1; prior_cat2;prior_cat3];

% Posterior probabilities
%ccolumns correspond to u,v,w
% rows correspond to class 1,2,3 
format short e
pre_posterior = (densities.* prior_matrix) ;
sum_poster = sum(pre_posterior,1); %sum of each column i.e all p(x|C)
u_posterior = pre_posterior(:,1)./sum_poster(1,1);
v_posterior = pre_posterior(:,2)./sum_poster(1,2);
w_posterior = pre_posterior(:,3)./sum_poster(1,3);
%For 28->
jjoined = [cat1;cat2;cat3];
labels = [ones(10,1); 2.*ones(10,1); 3.*ones(10,1)];

% example KNN(u', 1, jjoined, labels);
