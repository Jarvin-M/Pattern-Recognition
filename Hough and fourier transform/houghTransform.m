%qn 2
% comparing myhough with hough
c = imread('data\Cameraman.tiff'); % qn 1

edges = edge(c,'canny'); % extract the edges 
figure;
subplot(2,1,1)
[hc, theta, rho] =hough(edges);
imagesc(hc, 'XData', theta, 'YData',rho) % imagesc displays data in the array hc as an image that uses the full range of colors in a map
title('Matlab native Hough transform');
xlabel('\theta	(degrees)'),ylabel('\rho');
axis on
colormap(gca, bone);
hold on;

subplot(2,1,2)
my_hc =myhough(edges);
%defining the theta and rho value limits from myhough function
t = (-90:1:90); %theta bounds
image_diag = round(sqrt(sum(size(edges).^2)));
r = (-image_diag:1:image_diag); %rho bounds
imagesc(my_hc, 'XData', t, 'YData',r) % imagesc displays data in the array hc as an image that uses the full range of colors in a map
title('myhough Transform');
xlabel('\theta	(degrees)'),ylabel('\rho');
axis on
colormap(gca, bone);