mu1 = [3 5];
mu2 = [2 1];
sigma1 = [1 0; 0 4];
sigma2 = [2 0; 0 1];
pw1 = 0.3;
pw2 = 0.7;

%1 Discriminant functions as bivariate quadratic functions g1 and g2
syms x y real;
%vec = [x y];
g1(x,y) = mvnpdf([x y], mu1,sigma1) * pw1;
gg1 = formula(g1);
gx1 = expand(simplify(log(gg1)));
[v1 ,position1] = coeffs(gx1,'All');
disp('g1xy');
disp(v1)
disp(position1)
%f(x,y) = (1/(sqrt(det(sigma1)*(2*pi)^2))*exp(-0.5*(hh-mu1)'*inv(sigma1)*(hh-mu1)));
%formulas(f)
% discriminant function for g2
g2(x,y) = mvnpdf([x y], mu2, sigma2) *pw2;
gg2 = formula(g2);
gxy2 = expand(simplify(log(gg2)));
[v2 ,position2] = coeffs(gxy2,'All');
disp('g2xy');
disp(v2)
disp(position2)

%g1(x,y) -g2(x,y) =0
decision_boundary = gx1 - gxy2 ;
gxy12 = formula(decision_boundary);
[v12 ,position12] = coeffs(gxy12,'All');
disp('g1xy-g2xy=0');
disp(v12)
disp(position12)

figure(1);
fimplicit(gxy12, [-10 20]);
title("Decision Boundary in range -10 to 20")
%solution = solve(decision_boundary, [x,y]);
%plot(solution.x, solution.y);
%[d,j] = solve(gg1,gg2);