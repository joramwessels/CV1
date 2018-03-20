clc; close all;

% Setup vlfeat
run('../../vlfeat-0.9.21/toolbox/vl_setup')

% Load images
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

[xy1, xy2] = keypoint_matching(boat1, boat2, true);
%%

n_its = 5 ; % number of iterations
n_points = 50 ; % number of points

trans_pars_1_2 = RANSAC(xy1, xy2, n_its , n_points); % transformation from 1 to 2
trans_pars_2_1 = RANSAC(xy2, xy1, n_its, n_points);  % transformation from 2 to 1
%%
clc; close all

% Show transformation from 1 to 2
im1_t = transform_img(boat1, trans_pars_1_2, 'builtin') ;
figure(1);
subplot(1, 2, 1)
imshow(im1_t)
subplot(1, 2, 2)
imshow(boat2)

% Show transformation from 2 to 1
im2_t = transform_img(boat2, trans_pars_2_1, 'builtin') ; 
figure(2);  
subplot(1, 2, 1)
imshow(im2_t)
subplot(1, 2, 2)
imshow(boat1)

%%
clc ; close all;
left = imread('left.jpg');
right = imread('right.jpg');

% keypoint_matching(left, right, true)
% keypoint_matching(right, left, true)
stitch( left, right)