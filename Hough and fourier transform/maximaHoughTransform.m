c = imread('data\Cameraman.tiff'); % qn 1

%qn 2
edges = edge(c,'canny'); % extract the edges 
[hc, theta, rho] =hough(edges);

%qn 3
%rho, the distance from the origin to the line along a vector perpendicular to the line, and
%theta, the angle in degrees between the x-axis and this vector
figure(1);
imagesc(hc, 'XData', theta, 'YData',rho) % imagesc displays data in the array hc as an image that uses the full range of colors in a map
title('Jarvin');
xlabel('\theta	(degrees)'),ylabel('\rho');
axis on
colormap(gca, bone);

% qn 4
hcTh = hc; 
hcTh(hcTh <0.999*max(hc(:)))=0;% threshold version of the accumulator array

%qn 5 - find the five strongest local maxima points in the unthresholded
%accumulator array
hp = houghpeaks(hc,5);

figure(2);
imagesc(hc, 'XData', theta, 'YData',rho) % imagesc displays data in the array hc as an image that uses the full range of colors in a map
title('Five strongest local maxima points in the unthresholded accumulator array');
xlabel('\theta	(degrees)'),ylabel('\rho');
axis on,hold on;
plot(theta(hp(:,2)),rho(hp(:,1)),'s', 'color','red');
colormap(gca, bone);

%qn 6 and 7
figure(3)
imshow(c)
hold on;

myhoughline(c,rho(hp(1,1)),theta(hp(1,2)));
title('Jarvin');

