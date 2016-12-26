
clc;
close all;
clear variables;
dbstop if error;

% Built-in images
tic
compute_all('image_left.png', 'image_right.png', 'params.mat')
toc

% Student images
tic
compute_all('my_image_left.png', 'my_image_right.png', 'my_params.mat')
toc