load_A = load("data_lvq_A.mat");
load_B = load("data_lvq_B.mat");

A = load_A.matA;
B = load_B.matB;

%qn1
figure(1);
scatter(A(:,1), A(:,2), 'b', 'filled');
hold on;
scatter(B(:,1), B(:,2), 'g', 'filled');
