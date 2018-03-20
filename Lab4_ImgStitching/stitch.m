function stitched_imgs = stitch( img1, img2 ) 

n_its = 20 ; % number of iterations
n_points = 30 ; % number of points

[xy1, xy2] = keypoint_matching( img1, img2, false);
trans_pars_2_1 = RANSAC(xy2, xy1, n_its, n_points);  % transformation from 2 to 1
im2_t = transform_img(img2, trans_pars_2_1, 'builtin') ;

figure(1);
subplot(1, 2, 1)
imshow(img1)
subplot(1, 2, 2)
imshow(im2_t)

[h, w, ~] = size(img2) ;
upleft_corn = [0,0] ;
lowleft_corn = [h,0] ;

upleft_corn_t = create_A( [0], [0] ) * trans_pars_2_1;
lowleft_corn_t = create_A( [0], [h] ) * trans_pars_2_1;
end

function [A_matrix] = create_A( x, y )
    len = max(size(x));
    A_matrix = zeros(2*len, 6);
    for i=1:len
        i_1 = 2 * i - 1;
        i_2 = 2 * i  ;
        A_matrix(i_1, :) = cat(2, x(:, i), y(:, i), 0, 0, 1, 0) ;
        A_matrix(i_2, :) = cat(2, 0, 0, x(:, i), y(:, i), 0, 1) ;
    end
end