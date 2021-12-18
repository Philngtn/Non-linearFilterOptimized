% Generate overlaping matrix of different estimation

M= 3;
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

