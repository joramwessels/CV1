function [f1, f2, matches,scores] = keypoint_matching(I1, I2, disp_imgs)


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
end
if c2 > 1
    im2 = rgb2gray(I2) ;
end
    im1 = single(I1);
    im2 = single(I2);

% Detect sift keypoints
[f1,d1] = vl_sift(im1) ;
[f2,d2] = vl_sift(im2) ;

% Match keypoints in images
[matches, scores] = vl_ubcmatch(d1, d2) ;

% Display results
if disp_imgs
    perm = randperm(size(matches,2)) ;
    sel = perm(1:50) ;
    matches = matches(:, sel) ;
    scores  = scores(sel) ;

    figure(2) ; clf ;
    imshow(cat(2, I1, I2),'InitialMagnification','fit') ;
    
    x1 = f1(1,matches(1,:)) ;
    x2 = f2(1,matches(2,:)) + size(I1,2) ;
    y1 = f1(2,matches(1,:)) ;
    y2 = f2(2,matches(2,:)) ;

    hold on ;
    h = line([x1 ; x2], [y1 ; y2]) ;
    set(h,'linewidth', 1, 'color', 'b') ;

    vl_plotframe(f1(:,matches(1,:))) ;
    f2(1,:) = f2(1,:) + size(I1,2) ;
    vl_plotframe(f2(:,matches(2,:))) ;
    axis image off ;

end
end