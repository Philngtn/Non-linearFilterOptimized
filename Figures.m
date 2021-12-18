%% Validation Data
% subplot(2,2,1)
% imagesc(GT1);
% title('(a)');
% axis off;
% subplot(2,2,2)
% imagesc(CST1);
% title('(b)');
% axis off;
% subplot(2,2,3)
% imagesc(GT2AI);
% title('(c)');
% axis off;
% subplot(2,2,4)
% imagesc(CST2AI);
% title('(d)');
% axis off;

%% Mean and varience 
[m,v] = meanNvar(T1Stacked,1);

subplot(2,2,1)
imagesc(GT1);
title({['Ground Truth T1'] ['(a)']});
axis off;
subplot(2,2,2)
imagesc(CST1);
title({['Noisy Image'] ['(a)']});
axis off;
subplot(2,2,3)
imagesc(m(:,:,2));
title({['Map of local means'] ['(c)']});
axis off;
subplot(2,2,4)
imagesc(v(:,:,2));
title({['Map of local variances'] ['(d)']});
axis off;

%% T1 ICMB ground truth and Restoration T1 with 7% and 9% noises added
close all;
subplot(2,2,1)
imagesc(I_n0_t1(:,:,85))
title({['Ground Truth T1'] ['with ICBM protocol at 7% noise']});
axis off;
subplot(2,2,2)
imagesc(I_n0_t1(:,:,85))
title({['Zoomed Ground Truth T1'] ['with ICBM protocol at 7% noise']});
axis off;
subplot(2,2,3)
imagesc(I_n0_t1(:,:,125))
title({['Ground Truth T1'] ['with ICBM protocol at 9% noise']});
axis off;
subplot(2,2,4)
imagesc(I_n0_t1(:,:,125))
title({['Zoomed Ground Truth T1'] ['with ICBM protocol at 9% noise']});
axis off;
% 7% noise
figure
T1Stacked_n7 = cat(3,I_n7_t1(:,:,84),I_n7_t1(:,:,85),I_n7_t1(:,:,86));
CST1_n7 = I_n7_t1(:,:,85);
opNL_T1_7 = opNLmeans(T1Stacked_n7);

subplot(2,2,1)
imagesc(CST1_n7)
title('Noisy image 7%');
axis off;
subplot(2,2,2)
imagesc(opNL_T1_7(:,:,2))
title('Optimized NL-means');
axis off;

%% T2 AI ground truth and Restoration T1 with 3% and 5% noises added
close all;
subplot(2,2,1)
imagesc(I_ai_n0_t2(:,:,40))
title({['Ground Truth T2'] ['with AI protocol at 3% noise']});
axis off;
subplot(2,2,2)
imagesc(I_ai_n0_t2(:,:,40))
title({['Zoomed Ground Truth T2'] ['with AI protocol at 3% noise']});
axis off;
subplot(2,2,3)
imagesc(I_ai_n0_t2(:,:,140))
title({['Ground Truth T2'] ['with AI protocol at 5% noise']});
axis off;
subplot(2,2,4)
imagesc(I_ai_n0_t2(:,:,140))
title({['Zoomed Ground Truth T2'] ['with AI protocol at 5% noise']});
axis off;
% 3% noise
figure
T2_ai_Stacked_n3 = cat(3,I_ai_n3_t2(:,:,39),I_ai_n3_t2(:,:,40),I_ai_n3_t2(:,:,41));
CST2_ai_n3 = I_ai_n3_t2(:,:,40);
opNL_T2_ai_3 = opNLmeans(T2_ai_Stacked_n3);

subplot(2,2,1)
imagesc(CST2_ai_n3)
title('Noisy image 3%');
axis off;
subplot(2,2,2)
imagesc(opNL_T2_ai_3(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST2_ai_n3)
title('Zoomed Noisy image 3%');
axis off;
subplot(2,2,4)
imagesc(opNL_T2_ai_3(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

% 5% noise
figure;
T2_ai_Stacked_n5 = cat(3,I_ai_n5_t2(:,:,139),I_ai_n5_t2(:,:,140),I_ai_n5_t2(:,:,141));
CST2_ai_n5 = I_ai_n5_t2(:,:,140);
opNL_T2_ai_5 = opNLmeans(T2_ai_Stacked_n5);

subplot(2,2,1)
imagesc(CST2_ai_n5)
title('Noisy image 5%');
axis off;
subplot(2,2,2)
imagesc(opNL_T2_ai_5(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST2_ai_n5)
title('Zoomed Noisy image 5%');
axis off;
subplot(2,2,4)
imagesc(opNL_T2_ai_5(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

%% T2 AI ground truth and Restoration T1 with 7% and 9% noises added
close all;
subplot(2,2,1)
imagesc(I_ai_n0_t2(:,:,120))
title({['Ground Truth T2'] ['with AI protocol at 7% noise']});
axis off;
subplot(2,2,2)
imagesc(I_ai_n0_t2(:,:,120))
title({['Zoomed Ground Truth T2'] ['with AI protocol at 7% noise']});
axis off;
subplot(2,2,3)
imagesc(I_ai_n0_t2(:,:,100))
title({['Ground Truth T2'] ['with AI protocol at 9% noise']});
axis off;
subplot(2,2,4)
imagesc(I_ai_n0_t2(:,:,100))
title({['Zoomed Ground Truth T2'] ['with AI protocol at 9% noise']});
axis off;
% 7% noise
figure
T2_ai_Stacked_n7 = cat(3,I_ai_n7_t2(:,:,119),I_ai_n7_t2(:,:,120),I_ai_n7_t2(:,:,121));
CST2_ai_n7 = I_ai_n7_t2(:,:,120);
opNL_T2_ai_7 = opNLmeans(T2_ai_Stacked_n7);

subplot(2,2,1)
imagesc(CST2_ai_n7)
title('Noisy image 7%');
axis off;
subplot(2,2,2)
imagesc(opNL_T2_ai_7(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST2_ai_n7)
title('Zoomed Noisy image 7%');
axis off;
subplot(2,2,4)
imagesc(opNL_T2_ai_7(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

% 9% noise
figure;
T2_ai_Stacked_n9 = cat(3,I_ai_n9_t2(:,:,99),I_ai_n9_t2(:,:,100),I_ai_n9_t2(:,:,101));
CST2_ai_n9 = I_ai_n9_t2(:,:,100);
opNL_T2_ai_9 = opNLmeans(T2_ai_Stacked_n9);

subplot(2,2,1)
imagesc(CST2_ai_n9)
title('Noisy image 9%');
axis off;
subplot(2,2,2)
imagesc(opNL_T2_ai_9(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST2_ai_n9)
title('Zoomed Noisy image 9%');
axis off;
subplot(2,2,4)
imagesc(opNL_T2_ai_9(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

 