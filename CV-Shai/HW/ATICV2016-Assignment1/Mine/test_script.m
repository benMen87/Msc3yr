%% Built-In files

% Clean
clc;
close all; 
clear variables;
dbstop if error;

% Parameters
max_err = 25;
inliers_percent = 0.8;

% Read the data:
img_src = imread('src.jpg'); 
img_dst = imread('dst.jpg'); 
load matches.mat

% Compute naive homography
tic;
H_naive = compute_homography_naive(match_p_src, match_p_dst);
fprintf('\n\nNaive Homography [%0.2f sec]\n', toc);
disp(H_naive)

% Test naive homography
tic;
[fit_percent, dist_mse] = test_homography(H_naive, match_p_src, match_p_dst, max_err);
fprintf('\n\nNaive Homography Test [%0.2f sec]\n', toc);
disp([fit_percent, dist_mse])

% Compute RANSAC homography
tic;
H_ransac = compute_homography(match_p_src, match_p_dst, inliers_percent, max_err);
fprintf('\n\nRANSAC Homography [%0.2f sec]\n', toc);
disp(H_ransac)

% Test RANSAC homography
tic;
[fit_percent, dist_mse] = test_homography(H_ransac, match_p_src, match_p_dst, max_err);
fprintf('\n\nRANSAC Homography Test [%0.2f sec]\n', toc);
disp([fit_percent, dist_mse])

% Build panorama
tic;
img_pan = panorama(img_src, img_dst, match_p_src, match_p_dst, inliers_percent, max_err);
fprintf('\n\nPanorama [%0.2f sec]\n', toc);
figure(101);
image(img_pan);
title('Super Duper Panorama')

%% Student Files

clear variables;

max_err = 25; % <<<<< YOU MAY CHANGE THIS
inliers_percent = 0.8; % <<<<< YOU MAY CHANGE THIS

img_src_test = imread('src_test.jpg'); 
img_dst_test = imread('dst_test.jpg'); 
load matches_test.mat

% Build student panorama
tic;
img_pan = panorama(img_src_test, img_dst_test, match_p_src, match_p_dst, inliers_percent, max_err);
fprintf('\n\nPanorama [%0.2f sec]\n', toc);
figure(102);
image(img_pan);
title('Even Better Panorama')


