original = im2double(imread('intrinsic_images/ball.png'));
reflect  = im2double(imread('intrinsic_images/ball_reflectance.png'));
shading  = im2double(imread('intrinsic_images/ball_shading.png'));

result = reflect .* shading;

imshow(result)

figure
subplot(2,2,1)
imshow(original)
title('Original image')

subplot(2,2,2)
imshow(reflect)
title('The reflection component')

subplot(2,2,3)
imshow(shading)
title('The shading component')

subplot(2, 2, 4)
imshow(result)
title('The element wise multiplication')