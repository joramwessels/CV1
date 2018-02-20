function [output_image] = correctcolor(input_image)

% applies gray world algorithm to an input image

% Initialization
output_image = zeros(size(input_image));

gray_value = 128/255;
input_image = im2double(input_image);

% Extract the individual red, green, and blue color channels.
R = input_image(:, :, 1);
G = input_image(:, :, 2);
B = input_image(:, :, 3);


output_image(:,:,1) = (gray_value/mean(R(:))) * R;
output_image(:,:,2) = (gray_value/mean(G(:))) * G;
output_image(:,:,3) = (gray_value/mean(B(:))) * B;
end