% Setup vlfeat
% run('../../vlfeat-0.9.21/toolbox/vl_setup')

boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

[matches, scores] = keypoint_matching(boat1, boat2, true);