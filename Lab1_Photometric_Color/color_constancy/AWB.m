clear
clc
close all

% Change the current folder to the folder of this m-file.
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));


input_image = imread('awb.jpg');

bla = correctcolor(input_image);

figure
subplot(1,2,1)
imshow(input_image)
title('Original image')

subplot(1,2,2)
imshow(bla)
title('Converted image')