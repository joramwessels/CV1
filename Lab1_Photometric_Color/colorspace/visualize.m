function visualize(input_image)

[~,~,channels] = size(input_image);

if channels == 3
    figure
    subplot(2,2,1)
    imshow(input_image)
    title('Converted image')

    subplot(2,2,2)
    imshow(input_image(:,:,1))
    title('Channel 1')

    subplot(2,2,3)
    imshow(input_image(:,:,2))
    title('Channel 2')

    subplot(2,2,4)
    imshow(input_image(:,:,3))
    title('Channel 3')

elseif channels == 4
    figure
    subplot(2,2,1)
    imshow(input_image(:,:,1))
    title('Lightness')

    subplot(2,2,2)
    imshow(input_image(:,:,2))
    title('Average')

    subplot(2,2,3)
    imshow(input_image(:,:,3))
    title('Luminosity')

    subplot(2,2,4)
    imshow(input_image(:,:,4))
    title('Matlab rgb2gray')

else
end

