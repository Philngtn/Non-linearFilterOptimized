%-----------------------------
% ELEC6661 Project:
% 
% An Optimized Blockwise Nonlocal Means Denoising
% Filter for 3-D Magnetic Resonance Images
% 
% Pierrick Coup?*, Pierre Yger, Sylvain Prima, Pierre Hellier, Charles Kervrann, and Christian Barillot
%-----------------------------
% Author: Ngoc Phuc Nguyen 
% SID: 40105544
% Email: philngtn@gmail.com
% Date: Nov-20-2020
%-----------------------------
clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter
M = 8; % Searching windows
d = 1; % Local neighborhood size
beta = 1; % Defined constant the smoothing parametter

% Voxel selection
sigmaSq = 0.5; % Std^2
mu = 0.95; % 

% Blockwise implementation parameters
n = 2;
alpha = 1; 

% Cubic Local neighborhood size 
N = (2*d + 1)^3; 
% Smoothing parameter controling decay exponential function
h = sqrt(2*beta*sigmaSq*N); % h

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading Images 
%T1
I_n0_t1 = loadminc('t1_icbm_normal_1mm_pn0_rf20.mnc');
I_n3_t1 = loadminc('t1_icbm_normal_1mm_pn3_rf20.mnc');
I_n5_t1 = loadminc('t1_icbm_normal_1mm_pn5_rf20.mnc');
I_n7_t1 = loadminc('t1_icbm_normal_1mm_pn7_rf20.mnc');
I_n9_t1 = loadminc('t1_icbm_normal_1mm_pn9_rf20.mnc');
%T2
I_n0_t2 = loadminc('t2_icbm_normal_1mm_pn0_rf20.mnc');
I_n3_t2 = loadminc('t2_icbm_normal_1mm_pn3_rf20.mnc');
I_n5_t2 = loadminc('t2_icbm_normal_1mm_pn5_rf20.mnc');
I_n7_t2 = loadminc('t2_icbm_normal_1mm_pn7_rf20.mnc');
I_n9_t2 = loadminc('t2_icbm_normal_1mm_pn9_rf20.mnc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%T2 ai MSL
I_ai_n0_t2 = loadminc('t2_ai_msles2_1mm_pn0_rf20.mnc');
I_ai_n3_t2 = loadminc('t2_ai_msles2_1mm_pn3_rf20.mnc');
I_ai_n5_t2 = loadminc('t2_ai_msles2_1mm_pn3_rf20.mnc');
I_ai_n7_t2 = loadminc('t2_ai_msles2_1mm_pn3_rf20.mnc');
I_ai_n9_t2 = loadminc('t2_ai_msles2_1mm_pn9_rf20.mnc');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stacked images for processing (only stack 3 consecutive pics for faster processing)
% ICBM
T1Stacked = cat(3,I_n9_t1(:,:,74),I_n9_t1(:,:,75),I_n9_t1(:,:,76));
GT1 = I_n0_t1(:,:,75);
CST1 = I_n9_t1(:,:,75);

T2Stacked = cat(3,I_n9_t2(:,:,99),I_n9_t2(:,:,100),I_n9_t2(:,:,101));
GT2 = I_n0_t2(:,:,100);
CST2 = I_n9_t2(:,:,100);

% MSL
T2StackedAI = cat(3,I_ai_n9_t2(:,:,104),I_ai_n9_t2(:,:,105),I_ai_n9_t2(:,:,106));
GT2AI = I_ai_n0_t2(:,:,105);
CST2AI = I_ai_n9_t2(:,:,105);

%% T2 with MS Lesions Ground Truth and 9% noise
close all;

% Ground Truth
subplot(2,1,1)
imagesc(GT2AI)
title('Ground Truth');
axis off;
subplot(2,1,2)
imagesc(GT2AI)
title('Zoomed Ground Truth');
axis off;

% Noisy Image and Denoise Image
figure;
opNL_T2AI = opNLmeans(T2StackedAI);
subplot(2,2,1)
imagesc(CST2AI)
title('Noisy image 9%');
axis off;
subplot(2,2,2)
imagesc(opNL_T2AI(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST2AI)
title('Noisy image 9%');
axis off;
subplot(2,2,4)
imagesc(opNL_T2AI(:,:,2))
title('Optimized NL-means');
axis off;

%% T1 ICMB ground truth and Restoration T1 with 3% and 5% noises added
close all;
% Ground Truth
subplot(2,2,1)
imagesc(I_n0_t1(:,:,111))
title({['Ground Truth T1'] ['with ICBM protocol at 3% noise']});
axis off;
subplot(2,2,2)
imagesc(I_n0_t1(:,:,111))
title({['Zoomed Ground Truth T1'] ['with ICBM protocol at 3% noise']});
axis off;
subplot(2,2,3)
imagesc(I_n0_t1(:,:,75))
title({['Ground Truth T1'] ['with ICBM protocol at 5% noise']});
axis off;
subplot(2,2,4)
imagesc(I_n0_t1(:,:,75))
title({['Zoomed Ground Truth T1'] ['with ICBM protocol at 5% noise']});
axis off;

% 3% noise
figure
T1Stacked_n3 = cat(3,I_n3_t1(:,:,74),I_n3_t1(:,:,75),I_n3_t1(:,:,76));
CST1_n3 = I_n3_t1(:,:,75);
opNL_T1_3 = opNLmeans(T1Stacked_n3);

subplot(2,2,1)
imagesc(CST1_n3)
title('Noisy image 3%');
axis off;
subplot(2,2,2)
imagesc(opNL_T1_3(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST1_n3)
title('Zoomed Noisy image 3%');
axis off;
subplot(2,2,4)
imagesc(opNL_T1_3(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

% 5% noise
figure;
T1Stacked_n5 = cat(3,I_n5_t1(:,:,110),I_n5_t1(:,:,111),I_n5_t1(:,:,112));
CST1_n5 = I_n5_t1(:,:,111);
opNL_T1_5 = opNLmeans(T1Stacked_n5);

subplot(2,2,1)
imagesc(CST1_n5)
title('Noisy image 5%');
axis off;
subplot(2,2,2)
imagesc(opNL_T1_5(:,:,2))
title('Optimized NL-means');
axis off;
subplot(2,2,3)
imagesc(CST1_n5)
title('Zoomed Noisy image 5%');
axis off;
subplot(2,2,4)
imagesc(opNL_T1_5(:,:,2))
title('Zoomed Optimized NL-means');
axis off;

 