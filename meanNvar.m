function [ mean_uN, var_uN ] = meanNvar(img_in,d)
%  Img_in : X*Y*Z images
%  mean_uN: mean of voxel which have neiborhood uN = (2*d + 1)^3
%  mean_uN has size X*Y*Z
%  var_uN: var of voxel which have neiborhood uN = (2*d + 1)^3
%  var_uN has size X*Y*Z

[x,y,z] = size(img_in);

mean_uN = zeros(x,y,z);
var_uN = zeros(x,y,z);

% padding the img_in for easy calculation

paddingImg_in = padarray(img_in,[d d d]);
paddingMean_uN = padarray(mean_uN,[d d d]);
paddingVar_uN = padarray(var_uN,[d d d]);

% size of padding img
[r,c,z] = size(paddingImg_in);

for k = 1+d:z-d
    for i = 1+d:r-d
        for j= 1+d:c-d
            
            temp =      [ paddingImg_in(i,j,k) paddingImg_in(i,j,k+1) paddingImg_in(i,j,k-1) ...
                          paddingImg_in(i+1,j,k) paddingImg_in(i+1,j,k+1) paddingImg_in(i+1,j,k-1) ...
                          paddingImg_in(i-1,j,k) paddingImg_in(i-1,j,k+1) paddingImg_in(i-1,j,k-1) ...
                          paddingImg_in(i,j+1,k) paddingImg_in(i,j+1,k+1) paddingImg_in(i,j+1,k-1) ...
                          paddingImg_in(i,j-1,k) paddingImg_in(i,j-1,k+1) paddingImg_in(i,j-1,k-1) ...
                          paddingImg_in(i+1,j+1,k) paddingImg_in(i+1,j+1,k+1) paddingImg_in(i+1,j+1,k-1) ...
                          paddingImg_in(i-1,j-1,k) paddingImg_in(i-1,j-1,k+1) paddingImg_in(i-1,j-1,k-1) ...
                          paddingImg_in(i+1,j-1,k) paddingImg_in(i+1,j-1,k+1) paddingImg_in(i+1,j-1,k-1) ...
                          paddingImg_in(i-1,j+1,k) paddingImg_in(i-1,j+1,k+1) paddingImg_in(i-1,j+1,k-1)];
            
            paddingMean_uN(i,j,k) = mean(temp);
            paddingVar_uN(i,j,k) = var(temp);
        end
    end
end

mean_uN = paddingMean_uN(1+d:end-d, 1+d:end-d, 1+d:end-d);
var_uN = paddingVar_uN(1+d:end-d, 1+d:end-d, 1+d:end-d);

end

