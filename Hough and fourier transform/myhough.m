function accumulator_array = myhough(edgemap)
% discrete set of values for theta and rho
%c = imread('data\Cameraman.tiff'); % qn 1

%qn 2
%edgemap = edge(c,'canny');
%theta

theta = (-90:1:90);

%rho -image diagonal
image_size = size(edgemap); % returns width and height of image
image_diag = round(sqrt(sum(image_size.^2)));
rho = (-image_diag:1:image_diag);

%foreground pixel indices (x,y)
[y,x] = find(edgemap); 
foreground_xy = [y x];

fore_length = length(foreground_xy(:,1)); %length of rows in the foreground pixels. Each row is (y,x)
% intialising the accumulator array

accumulator_array = zeros(length(rho),length(theta) );
for row=1: fore_length
    %calculate the rho value for all theta
    x_row = foreground_xy(row,2);
    y_row = foreground_xy(row,1);
    
    %rho =  x cos(theta) + ysin(theta) return a row vector of all the rho
    %values for all thetas previously defined. 
    % floor - round values to the nearest integer less than or equal to rho
    for theta_index =1 :length(theta)
        angle = deg2rad(theta(theta_index));
        rho1 = x_row*cos(angle) + y_row*sin(angle);
        floor(rho1);
        [d,irho] = min(abs(rho-rho1)); %finding the closest indice to the rho1
        if d<=1
            accumulator_array(irho,theta_index) = accumulator_array(irho,theta_index) + 1;
        end
    end
end

end

