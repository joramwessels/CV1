function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb

% Initialization
output_image = zeros(size(input_image));

% Extract the individual red, green, and blue color channels.
R = input_image(:, :, 1);
G = input_image(:, :, 2);
B = input_image(:, :, 3);

output_image(:,:,1) = (R)./(R+G+B);
output_image(:,:,2) = (G)./(R+G+B);
output_image(:,:,3) = (B)./(R+G+B);
end

