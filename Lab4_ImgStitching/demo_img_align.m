clc; close all;

% Setup vlfeat
run('../../vlfeat-0.9.21/toolbox/vl_setup')

% Load images
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

% [xy1, xy2] = keypoint_matching(boat1, boat2, false);
% trans_pars = RANSAC(xy1, xy2, 10, 20);
xy = transform_img(boat1, trans_pars, 'nn')