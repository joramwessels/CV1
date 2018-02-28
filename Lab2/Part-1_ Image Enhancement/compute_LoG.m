function imOut = compute_LoG(image, LOG_type, varargin)

switch LOG_type
    case 1
        %method 1
        filter = gauss2D(0.5, 5);
        gaussian = imfilter(image, filter);
        h = fspecial('laplacian');
        imOut = imfilter(gaussian, h);
    case 2
        %method 2
        filter = fspecial('log',5,0.5);
        imOut = imfilter(image, filter);
    case 3
        %method 3
        scale_1 = varargin{1};
        scale_2 = varargin{2};
        filter_1 = gauss2D(scale_1, 5);
        filter_2 = gauss2D(scale_2, 5);
        imOut = imfilter(image, filter_1) - imfilter(image, filter_2);
end
end

