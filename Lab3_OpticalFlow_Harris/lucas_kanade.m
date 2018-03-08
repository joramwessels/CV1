function [V, C] = lucas_kanade(im1, im2, r_size)
    [x_len, y_len] = size(im1);
    x_regions = floor(x_len/r_size);
    y_regions = floor(y_len/r_size);
    C = zeros([x_regions, y_regions, 2]);
    V = zeros([x_regions, y_regions, 2]);
    for y = 1:x_regions
        for x = 1:y_regions
            
            % "divide on non-overlapping 15x15 regions"
            x_start = x*r_size - r_size +1;
            x_end   = min(x*r_size, x_len);
            y_start = y*r_size - r_size +1;
            y_end   = min(y*r_size, y_len);
            region1 = im1(y_start:y_end, x_start:x_end);
            region2 = im2(y_start:y_end, x_start:x_end);
            
            % for each region compute A, A.T, and b...
            A  = get_A(region1);
            AT = A.';
            b  = get_b(region1, region2);
            
            % ...then estimate optical flow using Eq. 20
            V(y, x, :) = inv(AT * A) * (AT * b);
            C(y, x, :) = [x*r_size - r_size/2, y*r_size - r_size/2];
            
        end
    end
    V = reshape(V, [x_regions*y_regions, 2]);
    C = reshape(C, [x_regions*y_regions, 2]);
end

function A = get_A(region1)
    [xlen, ylen] = size(region1);
    len = xlen * ylen;
    [Ix, Iy] = gradient(region1);
    A = cat(2, reshape(Ix, [len, 1]), reshape(Iy, [len, 1]));
end

function b = get_b(region1, region2)
    [xlen, ylen] = size(region1);
    len = xlen * ylen;
    r1  = reshape(region1, [len, 1]);
    r2  = reshape(region2, [len, 1]);
    b   = r1 - r2;
end