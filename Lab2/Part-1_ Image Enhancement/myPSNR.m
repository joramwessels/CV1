function [ PSNR ] = myPSNR( orig_image, approx_image )
I_max = max(orig_image(:));
[M,N,C] = size(orig_image);
sq_diff = (orig_image - approx_image).^2;
MSE = sum(sq_diff(:))/(M*N*C);
PSNR = 10 * log10(I_max^2/MSE);
end

