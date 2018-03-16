function img1_t = transform_img( img1, trans_pars, transf_meth )
    
    if nargin < 3
        transf_meth = 'builtin' ;
    end
    
%     [h, w, ~] = size(img1) ;
    
    Transform = zeros([3, 3]);
    M = [trans_pars(1), trans_pars(2); trans_pars(3),trans_pars(4)];
    T = [trans_pars(5); trans_pars(6); 1];
    Transform(1:2, 1:2) = M;
    Transform(3, 1:3) = T;
    
    if strcmp(transf_meth, 'builtin')
        img1_t = imtransform(img1, maketform('affine', Transform));
    elseif strcmp(transf_meth, 'nn')
%         [Y, X] = ndgrid(1:h, 1:w) ;
%         xy = cat(2, X(:), Y(:)) ;
%         xy_t = zeros(size(xy)) ;
%         
%         for i=1:length(xy)
%             xi = xy(i, 1) ;
%             yi = xy(i, 2) ;
%             Ai = create_A( xi, yi ) ;
%             xy_t(i, :) ;
    % determining the size of the canvas
%     [start1, start2, max_dims] = get_max_dimensions(Transform, im1, im2);
%     stitch = zeros(max_dims);
%         end
    else
        sprintf('Image transformation method "%s" not recognized.', transf_meth)
    end
end

function [start1, start2, max_dims] = get_max_dimensions(T, im1, im2)
    % calculates the corner coordinates of the transfored image
    % to determine the height and width of the stiched image
    %
    % start1 and -2 say where to start printing the images on the canvas,
    % max_dims tells the dimensions of the canvas itself.
    [h, w] = size(im2);
    corners = zeros([4, 3]);
    corners(1, :) = [1, 1, 1] * T;
    corners(2, :) = [1, w, 1] * T;
    corners(3, :) = [h, 1, 1] * T;
    corners(4, :) = [h, w, 1] * T;
    mins = min(corners);
    maxs = max(corners);
    max_dims = round(cat(1, mins(1:2), maxs(1:2)));
    
    start1 = ones([1, 2]);
    start2 = ones([1, 2]);
    
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