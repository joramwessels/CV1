function stitch = stitch(im1, im2)
    [xy1, xy2] = keypoint_matching(im1, im2);
    bt = RANSAC(xy1, xy2, 10, 50);
    Transform = zeros([3, 3]);
    M = [bt(1), bt(2); bt(3), bt(4)];
    T = [bt(5); bt(6); 1];
    Transform(1:2, 1:2) = M;
    Transform(3, 1:3) = T;
    
    % determining the size of the canvas
    [start1, start2, max_dims] = get_max_dimensions(Transform, im1, im2);
    stitch = zeros(max_dims);
    
    % printing the transformed image on the canvas
    im2 = imtransform(im2, maketform('affine', Transform));
    [h, w] = size(im2);
    sh = start2(1);
    sw = start2(2);
    stitch(sh:sh+h-1, sw:sw+w-1) = im2;
    
    % printing the unchanged image onto the canvas
    [h, w] = size(im1);
    sh = start1(1);
    sw = start1(2);
    stitch(sh:(sh+h-1), sw:(sw+w-1)) = im1;
    
    stitch = stitch / max(max(stitch));
    imshow(stitch);
end

function [start1, start2, max_dims] = get_max_dimensions(T, im1, im2)
    % calculates the corner coordinates of the transfored image
    % to determine the height and width of the stiched image
    %
    % start1 and -2 say where to start printing the images on the canvas,
    % max_dims tells the dimensions of the canvas itself.
    [h, w] = size(im2);
    corners = zeros([4, 3]);
    corners(1, :) = [0, 0, 1] * T;
    corners(2, :) = [0, w, 1] * T;
    corners(3, :) = [h, 0, 1] * T;
    corners(4, :) = [h, w, 1] * T;
    mins = min(corners);
    maxs = max(corners);
    max_dims = round(cat(1, mins(1:2), maxs(1:2)));
    
    start1 = zeros([1, 2]);
    start2 = zeros([1, 2]);
    
    if max_dims(1, 1) < 1
        start1(1) = round(-max_dims(1, 1));
        start2(1) = 1;
    else
        start1(1) = 1;
        start2(1) = round(max_dims(1, 1));
    end
    
    if max_dims(1, 2) < 1
        start1(2) = round(-max_dims(1, 2));
        start2(2) = 1;
    else
        start1(2) = 1;
        start2(2) = round(max_dims(1, 2));
    end
    
    [h, w] = size(im1);
    max_dims(1, 1) = min(max_dims(1, 1), 1);
    max_dims(1, 2) = min(max_dims(1, 2), 1);
    max_dims(2, 1) = max(max_dims(2, 1), h);
    max_dims(2, 2) = max(max_dims(2, 2), w);
    
    height = max_dims(2, 1) - max_dims(1, 1);
    width  = max_dims(2, 2) - max_dims(1, 2);
    max_dims = [height, width];
end