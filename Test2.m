clc;
close all;

for i = 90:135
    imagesc(I_noise0_t2(:,:,i))
    title([num2str(i)]);
    pause(0.5)
end