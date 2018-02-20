% test your code by using this simple script

clear
clc
close all

% Change the current folder to the folder of this m-file.
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));


I = imread('peppers.png');

J = ConvertColorSpace(I,'opponent');
 
close all
J = ConvertColorSpace(I,'rgb');

close all
J = ConvertColorSpace(I,'hsv');

close all
J = ConvertColorSpace(I,'ycbcr');

close all
J = ConvertColorSpace(I,'gray'); 