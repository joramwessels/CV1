function G = gauss1D( sigma , kernel_size )
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    fraction = ones(1, kernel_size)*(1/sigma*sqrt(2*pi));
    exponent = ones(1, kernel_size);
    for i = 1:kernel_size
        x = i -1 -floor(kernel_size/2);
        exponent(1, i) = exp(-x^2/(2*sigma^2));
    end
    G = fraction .* exponent;
    G = G / sum(G);
end