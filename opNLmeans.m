function [ img_out ] = opNLmeans(img_in)
% --------------------------------------------------
% img_in : a set of consecutive images 
% 
% img_out: the denoised images using opNLmean technique
% --------------------------------------------------

% Parameter
M = 5; % Diameter of searching windows centered around voxel xi
localArea = 1; % Local neighborhood center around voxel xi , FIXED, NO CHANGE
B = 1; % Defined constant the smoothing parametter

% Searching volume 
% V = (2*M +1)^3 means we search in a 11*11*11 cubic

% Voxel selection
sigmaSq = 0.5; % Std^2
mu = 0.95; % 

% Size of images in
[x,y,z] = size(img_in);
% Output has the same size of input
img_out = zeros(x,y,z);

% Compute the mean and variance of image block
[mean , var] = meanNvar(img_in, localArea);
stdSq = stdSQ(img_in);

% Searching Boundary
V = -M:1:M;

% Padding the inputs and its calculation
paddingImg = padarray(img_in,[localArea localArea localArea]);
paddingMean = padarray(mean,[localArea localArea localArea]);
paddingVar = padarray(var,[localArea localArea localArea]);
paddingImg_out = padarray(img_out, [localArea localArea localArea]);

% Size of padding input
[padx, pady, padz] = size(paddingImg);

% Selecting voxel Ni
% Process each layer
for k = (1+localArea):(padz-localArea)
    
    % Process by chosing x and y     
    for i = (1+localArea):(padx-localArea)
        for j = (1+localArea):(pady-localArea)
              
        % Identify and narrow the search boundary 
            k1 = k+V;
            i1 = i+V;
            j1 = j+V;
            
            k1 = k1(k1>localArea);
            i1 = i1(i1>localArea);
            j1 = j1(j1>localArea);
            
            k1 = k1(k1<padz);
            i1 = i1(i1<padx);
            j1 = j1(j1<pady);
            
%           Loop around the seaching boundary
%           Nj            
            % Local weighs
              weigh = [];
            valueNj = [];
            
            
            for d = min(k1):max(k1)      
                for r = min(i1):max(i1)
                    for c = min(j1):max(j1)
%                         
%                         if(r == i && c == j && d == k)
%                             continue; end
%                         
                            meanCondition = paddingMean(i,j,k)/paddingMean(r,c,d);
                            varCondition = paddingVar(i,j,k)/paddingVar(r,c,d);
                            
                        if ( meanCondition > mu && meanCondition < (1/mu) ...
                            &&  varCondition > sigmaSq && varCondition < 1/sigmaSq)
                            
                            Ni = [ paddingImg(i,j,k) paddingImg(i,j,k-1) paddingImg(i,j,k+1) ...
                                   paddingImg(i+1,j,k) paddingImg(i+1,j,k-1) paddingImg(i+1,j,k+1) ...
                                   paddingImg(i-1,j,k) paddingImg(i-1,j,k-1) paddingImg(i-1,j,k+1) ...
                                   paddingImg(i,j+1,k) paddingImg(i,j+1,k-1) paddingImg(i,j+1,k+1) ...
                                   paddingImg(i,j-1,k) paddingImg(i,j-1,k-1) paddingImg(i,j-1,k+1) ...
                                   paddingImg(i+1,j+1,k) paddingImg(i+1,j+1,k-1) paddingImg(i+1,j+1,k+1) ...
                                   paddingImg(i-1,j-1,k) paddingImg(i-1,j-1,k-1) paddingImg(i-1,j-1,k+1) ...
                                   paddingImg(i+1,j-1,k) paddingImg(i+1,j-1,k-1) paddingImg(i+1,j-1,k+1) ...
                                   paddingImg(i-1,j+1,k) paddingImg(i-1,j+1,k-1) paddingImg(i-1,j+1,k+1)];
                               
                            Nj = [ paddingImg(r,c,d) paddingImg(r,c,d-1) paddingImg(r,c,d+1) ...
                                   paddingImg(r+1,c,d) paddingImg(r+1,c,d-1) paddingImg(r+1,c,d+1) ...
                                   paddingImg(r-1,c,d) paddingImg(r-1,c,d-1) paddingImg(r-1,c,d+1) ...
                                   paddingImg(r,c+1,d) paddingImg(r,c+1,d-1) paddingImg(r,c+1,d+1) ...
                                   paddingImg(r,c-1,d) paddingImg(r,c-1,d-1) paddingImg(r,c-1,d+1) ...
                                   paddingImg(r+1,c+1,d) paddingImg(r+1,c+1,d-1) paddingImg(r+1,c+1,d+1) ...
                                   paddingImg(r-1,c-1,d) paddingImg(r-1,c-1,d-1) paddingImg(r-1,c-1,d+1) ...
                                   paddingImg(r+1,c-1,d) paddingImg(r+1,c-1,d-1) paddingImg(r+1,c-1,d+1) ...
                                   paddingImg(r-1,c+1,d) paddingImg(r-1,c+1,d-1) paddingImg(r-1,c+1,d+1)];
                               
                               
                            L2 = sum((Ni - Nj).^2)/27;
                               
                            tempW = exp(-L2/(2*B*stdSq(1,k-1)*(localArea+1)^3));
                            tempV = paddingImg(r,c,d);
                            
                            
                            weigh = cat(2,weigh,tempW);
                            valueNj = cat(2,valueNj,tempV);
                        end                        
                    end
                end
            end
        
            
                            
            weigh = weigh./sum(weigh);
            % Restored point
            paddingImg_out(i,j,k) = sum(weigh.*valueNj);
            
        end
    end
end


img_out = paddingImg_out(2:end-1,2:end-1,2:end-1);


end

