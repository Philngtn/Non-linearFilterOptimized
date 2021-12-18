function [ std_img ] = stdSQ( imgs_in )
%  imgs_in is the set of consecutive images which the middle pic is the
%  processing images and other pics are for calculating std of the middle
%  image.
%  imgs_in has size X*Y*Z
%  
%  std_img is the std of processing image for smoothing parameter
%  std_img has size 1*Z

[x,y,z] = size(imgs_in);
std_img = zeros(1,z);

% Padding imgs_im
% While we takes 6 neighborhood of voxel so we need to pad array with 0's 
% in the edge and zeros matrix (X*Y) in front and back of processing images
paddingImg = padarray(imgs_in,[1 1 1]);
[r,c,d] = size(paddingImg);


for k = 2:d-1
    for i= 2:r-1
        for j = 2:c-1
            sumNeighbor = paddingImg(i+1,j,k) + paddingImg(i-1,j,k) +...
                          paddingImg(i,j+1,k) + paddingImg(i,j-1,k) +...
                          paddingImg(i,j,k+1) + paddingImg(i,j,k-1);
                  
            ei = sqrt(6/7)*(paddingImg(i,j,k) - sumNeighbor/6);
            std_img(1,k-1) = std_img(1,k-1) + ei^2;
        end 
    end
    std_img(1,k-1) = std_img(1,k-1)/(x*y);
end
end