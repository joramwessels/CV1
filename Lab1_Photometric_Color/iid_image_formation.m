original = imread('intrinsic_images/ball.png');
reflect  = imread('intrinsic_images/ball_reflectance.png');
shading  = imread('intrinsic_images/ball_shading.png');

result = reflect .* shading;

imshow(result)