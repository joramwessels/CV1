function [xy1, xy2] = keypoint_matching( I1, I2, disp_imgs )


    % Input argument parsing
    if nargin < 3
        disp_imgs = false;
    end

    % Determine number of color channels
    c1 = size(I1,3);
    c2 = size(I2,3);


    % Convert to grayscale, if needed
    if c1 > 1
        im1 = rgb2gray(I1) ;
        im1 = single(im1) ;
    else
        im1 = single(I1) ; 
    end
    if c2 > 1
        im2 = rgb2gray(I2) ;
        im2 = single(im2) ;
    else
        im2 = single(I2) ; 
    end

    % Detect sift keypoints
    [f1,d1] = vl_sift(im1) ;
    [f2,d2] = vl_sift(im2) ;

    % Match keypoints in images
    [matches, ~] = vl_ubcmatch(d1, d2) ;

    % Find corresponding x, y coordinates     
    x1 = f1(1,matches(1,:)) ;
    x2 = f2(1,matches(2,:)) ; 
    y1 = f1(2,matches(1,:)) ;
    y2 = f2(2,matches(2,:)) ;

    xy1 = cat(1, x1, y1) ;
    xy2 = cat(1, x2, y2) ;

    % Display results
    if disp_imgs
        perm = randperm(size(matches,2)) ;
        sel = perm(1:50) ;
        matches = matches(:, sel) ;

        figure(2) ; clf ;
        imshow(cat(2, I1, I2),'InitialMagnification','fit') ;

    %   Shift x-coordinates of right image
        x2_t = x2 + size(I1,2) ;

        hold on ;
        h = line([x1(:, sel) ; x2_t(:, sel)], [y1(:, sel) ; y2(:, sel)]) ;
        set(h,'linewidth', 1, 'color', 'b') ;

        vl_plotframe(f1(:,matches(1,:))) ;
        f2(1,:) = f2(1,:) + size(I1,2) ;
        vl_plotframe(f2(:,matches(2,:))) ;
        axis image off ;

    end
end
