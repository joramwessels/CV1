clc; close all;

% Setup vlfeat
run('../../vlfeat-0.9.21/toolbox/vl_setup')

% Load images
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

[f1, f2, matches, scores] = keypoint_matching(boat1, boat2, false);
trans_pars = RANSAC(f1, f2, matches, 1, 50);