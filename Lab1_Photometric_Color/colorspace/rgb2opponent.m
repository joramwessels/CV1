function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space

% Initialization
output_image = zeros(size(input_image));

% Extract the individual red, green, and blue color channels.
R = input_image(:, :, 1);
G = input_image(:, :, 2);
B = input_image(:, :, 3);

output_image(:,:,1) = (R-G)/sqrt(2);
output_image(:,:,2) = (R+G-2*B)/sqrt(6);
output_image(:,:,3) = (R+G+B)/sqrt(3);
end

