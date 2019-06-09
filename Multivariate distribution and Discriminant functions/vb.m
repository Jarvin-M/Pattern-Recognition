syms x y
var = [x; y];

mu1 = [3; 5];
C1  = [1 0; 0 4];
P1  = 0.3;

mu2 = [2; 1];
C2  = [2 0; 0 1];
P2  = 0.7;

g1 = - (var - mu1).' * inv(C1) * (var - mu1) / 2 - log(det(C1)) / 2 + log(P1);
g2 = - (var - mu2).' * inv(C2) * (var - mu2) / 2 - log(det(C2)) / 2 + log(P2);

order = coeffs(x^2 + 2*y^2 + 3*x*y + 4*x + 5*y + 6);
[~, ordered] = sort(order);

c1 = coeffs(g1, 'All');
c2 = coeffs(g2, 'All');
c12 = coeffs(g1 - g2, 'All');

c1(ordered)
c2(ordered)
c12(ordered)

figure
    fimplicit(g1 - g2 == 0)
    title("Decision boundary for classification to two normal distributions")
    xlim([-10 20]);
    ylim([-10 20]);
