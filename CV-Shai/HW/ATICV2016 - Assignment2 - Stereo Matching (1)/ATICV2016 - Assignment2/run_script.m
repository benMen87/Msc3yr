
clc;
close all;
clear variables;
dbstop if error;

% Built-in images
%compute_all('image_left.png', 'image_right.png', 'params.mat')

% Student images
compute_all('my_image_left.png', 'my_image_right.png', 'my_params.mat')
