r_size = 15;

im  = im2double(imread('synth1.pgm'));
im1 = im2double(imread('synth1.pgm'));
im2 = im2double(imread('synth2.pgm'));

% compute optical flow vectors
[V, C] = lucas_kanade(im1, im2, r_size);

% plot vectors on image using quiver
show_flow(im, V, C, r_size);

% and for the sphere
im  = im2double(imread('sphere1.ppm'));
im1 = im2double(rgb2gray(imread('sphere1.ppm')));
im2 = im2double(rgb2gray(imread('sphere2.ppm')));
[V, C] = lucas_kanade(im1, im2, r_size);
show_flow(im, V, C, r_size);


function show_flow(im, vectors, centers, r_size)
    start = ceil(r_size/2);
    [xend, yend] = size(im);
    x = centers(:, 1);
    y = centers(:, 2);
    u = vectors(:, 1);
    v = vectors(:, 2);
    figure
    imshow(im);
    hold on;
    quiver(x, y, u, v);
end