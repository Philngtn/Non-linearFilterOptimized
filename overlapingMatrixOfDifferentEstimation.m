function [ overLapM ] = overlapingMatrixOfDifferentEstimation(M)
% Generate overlaping matrix of different estimation for latter division of
% each voxel x_i
% 
% x in e.g. are x_ik are equaly distribute along the search windows and overlap with
% its neighborhood (alpha = 1) , overlapping blocks size (2*alpha + 1)^3
% choose alpha = 1 => n = 2 ( distance bw 2 ovelaping blocks = 2) 
% 
% e.g: n = 2, M = 3
%      1     1     2     1     2     1     1
%      1     x     2     x     2     x     1
%      2     2     4     2     4     2     2
%      1     x     2     x     2     x     1
%      2     2     4     2     4     2     2
%      1     x     2     x     2     x     1
%      1     1     2     1     2     1     1

overLapM = zeros(2*M+1,2*M+1);
[x,y] = size(overLapM);

for i = 2:x-1
    for j = 2:y-1
        if mod(i,2) 
            if mod(j,2)
                overLapM(i,j) = 4;
            else
                overLapM(i,j) = 2;
             end
        else
            if mod(j,2)
                overLapM(i,j) = 2;
            else
                overLapM(i,j) = 1;
            end
        end
    end
end

for i = 1:x
    if i == 1 || i == x
        for j = 1:y
            if (i == 1 && j == 1) || (i == 1 && j == y) || (i == x && j == 1) ...
                || (i == x && j == y)    
                overLapM(i,j) = 1;
            elseif mod(j,2) == 0
                overLapM(i,j) = 1;
            else
                overLapM(i,j) = 2;
            end
        end
    else
        for j = 1:y-1:y
            if mod(i,2) == 0
                overLapM(i,j) = 1;
            else
                overLapM(i,j) = 2;
            end
        end
    end
end

end

