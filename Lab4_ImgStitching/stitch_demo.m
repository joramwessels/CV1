im1 = imread('left.jpg');
im2 = imread('right.jpg');
im3 = stitch(im1, im2);
imshow(im3);