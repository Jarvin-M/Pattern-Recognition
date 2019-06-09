mu = [3 4];
sigma =[1 0; 0 2];
x =(-10:.3:10);

[X,Y] = meshgrid(x,x);

%mulitvariate normal distribution
% f(x,mu,sigma) = (1/(sqrt(det(sigma)*(2*pie)^d)
% *exp(-0.5(x-mu)^t*sigma^-1*(x-mu)

Z = mvnpdf([X(:) Y(:)], mu, sigma);
Z = reshape(Z, length(x), length(x));

surf(X,Y,Z);

%question 2
%d2 = mahal(Y,X) returns the squared Mahalanobis distance of 
%each observation in Y to the reference samples in X.
refer_X = mvnrnd(mu,sigma, 10000);

%Question 2
disp('Question 2');
disp(mahal([10 10], refer_X));

%Question 3
disp('Question 3');
disp(mahal([0 0], refer_X));

%Question 4
disp('Question 4');
disp(mahal([3 4], refer_X));

%Question 5
disp('Question 5');
disp(mahal([6 8], refer_X));