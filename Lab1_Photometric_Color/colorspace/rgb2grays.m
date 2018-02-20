 function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

[h, w, ~] = size(input_image);
output_image = zeros(h,w,4);

% lightness method
output_image(:,:,1) = (max(input_image, [], 3) ...
                       - min(input_image, [], 3))/2;

% average method
output_image(:,:,2) = sum(input_image, 3)/3;

% luminosity method
output_image(:,:,3) = 0.21*input_image(:,:,1) ...
                    + 0.72*input_image(:,:,2) + 0.07*input_image(:,:,3);

% built-in MATLAB function 
output_image(:,:,4) = rgb2gray(input_image);
 
end

