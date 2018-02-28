
%% Task 7.4
img_gaussian_3__0_5 = denoise(img_gaussian, 'gaussian', 3, 0.5);
img_gaussian_5__0_5 = denoise(img_gaussian, 'gaussian', 5, 0.5);
img_gaussian_7__0_5 = denoise(img_gaussian, 'gaussian', 7, 0.5);
img_gaussian_7__1 = denoise(img_gaussian, 'gaussian', 7, 1);
img_gaussian_3__1 = denoise(img_gaussian, 'gaussian', 3, 1);
img_gaussian_5__1 = denoise(img_gaussian, 'gaussian', 5, 1);
img_gaussian_7__1 = denoise(img_gaussian, 'gaussian', 7, 1);
img_gaussian_3__2 = denoise(img_gaussian, 'gaussian', 3, 2);
img_gaussian_5__2 = denoise(img_gaussian, 'gaussian', 5, 2);
img_gaussian_7__2 = denoise(img_gaussian, 'gaussian', 7, 2);



% imshow(img_gaussian_3__0_5)
% imshow(img_gaussian_5__0_5)
% imshow(img_gaussian_7__0_5)
% imshow(img_gaussian_3__1)
% imshow(img_gaussian_5__1)
% imshow(img_gaussian_7__1)
% imshow(img_gaussian_3__2)
% imshow(img_gaussian_5__2)
% imshow(img_gaussian_7__2)

%% Task 7.5

disp(myPSNR(img_gaussian, img_gaussian_7__2))

%% Task 7.6

clc

img_box_5 = denoise(img_gaussian, 'box', 5);
img_median_5 = denoise(img_gaussian, 'median', 5);

disp(myPSNR(img_gaussian, img_box_5))
disp(myPSNR(img_gaussian, img_gaussian_7__2))
disp(myPSNR(img_gaussian, img_median_5))

% imshow(img_box_5)
% figure
% imshow(img_median_5)
% figure
imshow(img_gaussian_7__2)

%% Task 8 

img_2 = im2double(imread('images/image2.jpg'));

[ Gx , Gy , im_mag , im_dir ] = compute_gradient(img_2);

% imshow(img_2)
figure 
imshow(Gx)
figure
imshow(Gy)
figure
imshow(im_mag)
figure
imshow(im_dir)

%% Task 9 

log_1 = compute_LoG(img_2, 1);
log_2 = compute_LoG(img_2, 2);
log_3 = compute_LoG(img_2, 3, 0.01, 10);

imshow(log_1)
figure
imshow(log_2)
figure
imshow(log_3)