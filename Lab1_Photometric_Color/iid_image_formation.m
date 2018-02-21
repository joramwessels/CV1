original = im2double(imread('intrinsic_images/ball.png'));
reflect  = im2double(imread('intrinsic_images/ball_reflectance.png'));
shading  = im2double(imread('intrinsic_images/ball_shading.png'));

result = reflect .* shading;

imshow(result)