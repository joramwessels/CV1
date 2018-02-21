original = im2double(imread('intrinsic_images/ball.png'));
reflect  = im2double(imread('intrinsic_images/ball_reflectance.png'));
shading  = im2double(imread('intrinsic_images/ball_shading.png'));

mask = im2double(zeros([266, 480, 3]));
mask(:, :, 2) = 1.0;
pure_green = reflect .* mask;
pure_green(pure_green>0) = 1;

green_ball = pure_green .* shading;

mask = im2double(zeros([266, 480, 3]));
mask(:, :, 1) = 1.0;
mask(:, :, 3) = 1.0;
magenta = reflect .* mask;
magenta(magenta>0) = 1;

magenta_ball = magenta .* shading;

figure
subplot(1,3,1)
imshow(original)
title('Original image')

subplot(1,3,2)
imshow(green_ball)
title('Pure green image')

subplot(1,3,3)
imshow(magenta_ball)
title('Magenta image')