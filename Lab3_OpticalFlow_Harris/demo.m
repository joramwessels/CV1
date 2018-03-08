img_1 = imread('person_toy/00000001.jpg');
[H, r, c ] = harris_corner_detector(img_1, 5e-5);

disp(randi(360))
img_rot = imrotate(img_1, randi(360));
[H, r, c ] = harris_corner_detector(img_rot, 5e-5);