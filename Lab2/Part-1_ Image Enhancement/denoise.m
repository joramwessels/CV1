function [ imOut ] = denoise( image, kernel_type, varargin)

kernel_size = varargin{1};

switch kernel_type
    case 'box'
        imOut = imboxfilt(image, kernel_size);
    case 'median'
        imOut = medfilt2(image, [kernel_size, kernel_size]);
    case 'gaussian'
        sigma = varargin{2};
        filter = gauss2D(sigma, kernel_size);
        imOut = imfilter(image, filter);
end
end