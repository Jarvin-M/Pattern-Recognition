
% qn 1
% foureir trnaform to visulize the spectrum of the periodic noise in the
% image
I = imread('data/dogGrayRipples.png');
I = im2double(I);
f = fft2(I); % tranform the input image to the fourier domain
fs = fftshift(f); % shift the 0 frequency to the center of the frequency domain
f = abs(fs);
f = log(1 +f);
figure;
imshow(f,[]);

%qn 3
	
[x, y] =getpts;
r = 11;

rows = size(f,1);cols = size(f,2);radius = r;center = [x'; y']; 
[xMat,yMat] = meshgrid(1:cols,1:rows);
mask=zeros(size(f));

for i =1:size(center,2)
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius)=1;
end


figure, hold on; imshow(~mask,[]);title('Mask')



%qn 10

fs=fs.*(~mask);
v = ifftshift(fs);
I = real(ifft2(v));
figure, imshow(I, []), title('S3555631');
