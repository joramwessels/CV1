original = imread('intrinsic_images/ball.png');
reflect  = imread('intrinsic_images/ball_reflectance.png');
shading  = imread('intrinsic_images/ball_shading.png');

mask = zeros([266, 480, 3]);
mask(:, :, 2) = 1.0;

pure_green = reflect .* mask;

imshow(pure_green)