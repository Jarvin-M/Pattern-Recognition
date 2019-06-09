% take input of image, \rho, r which is a distance value in pixels and theta
% - angle value in degrees
% Draws aline on the input image at a perpendicular distance \rho
function myhoughline(image,r, theta)
%MYHOUGHLINE Summary of this function goes here
%   Detailed explanation goes here
[x,y] = size(image);
angle = deg2rad(theta);

if sin(angle) ==0
    line([r r], [0,y], 'Color','red');
else
    line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red'); 
end

