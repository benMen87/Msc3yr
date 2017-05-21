%Computer Vision -  HW 1

close all
clear all
%%
%LOAD ENVIORMENT IMAGES AND MATCHING POINTS\
load matches_perfect
I_dst = imread('dst.jpg');
I_src = imread('src.jpg');

%mark points on source and dest images
I_marked_src = insertMarker(I_src, match_p_src', 'x', 'color', 'red', 'size', 10);
I_marked_dst = insertMarker(I_dst, match_p_dst',  'x', 'color', 'red', 'size', 10);

%plot 
figure;
imshow(I_marked_dst);
title('Dst image with perfect matching point marked');
figure;
imshow(I_marked_src);
title('Source image with perfect matching point marked');

%LOAD PARTIAL MATCHING POINTS 
load matches

%mark points on source and dest images
I_marked_src = insertMarker(I_src, match_p_src', 'x', 'color', 'red', 'size', 10);
I_marked_dst = insertMarker(I_dst, match_p_dst', 'x', 'color', 'red', 'size', 10);

%plot 
figure;
imshow(I_marked_dst);
title('Dst image with partial matching point marked');
figure;
imshow(I_marked_src);
title('Source image with partial matching point marked');

%%
% Part A - compute homograph transform  
%perfect match
clear clear match_p_*
close all
load matches_perfect
H = compute_homography_naive(match_p_src, match_p_dst);
H = reshape(H, 3, 3)';

I_panorama = forward_mapping(I_src, I_dst, H);
figure;
imshow(I_panorama);
title('merged images - prefect');
%%
%partial match
clear clear match_p_*
load matches

H_partial = compute_homography_naive(match_p_src, match_p_dst);
H_partial = reshape(H_partial, 3, 3)';

I_panorama = forward_mapping(I_src, I_dst, H_partial);
figure;
imshow(I_panorama);
title('merged images - partial match');

%%
%ransac

clear clear match_p_*
load matches

max_err = 5;
inliers_percent = 0.8;

H_partial_ransac = compute_homography(match_p_src, match_p_dst, ...
                   inliers_percent, max_err);
I_panorama = forward_mapping(I_src, I_dst, H_partial_ransac);
figure;
imshow(I_panorama);
title('merged images - partial match using ransac');
