function best_trans_pars = RANSAC( xy1, xy2, N, P )
% CONVERTS COORDINATES OF IMAGE 1 TO COUNTERPARTS IN IMAGE 2


r = 10; % allowed radius for inliers
max_num_inliers = 0;

for i=1:N
    
%   Randomly select P matches
    perm = randperm(size(xy1,2)) ;
    sel = perm(1:P) ;
    x1 = xy1(1, sel) ;
    y1 = xy1(2, sel) ;
    x2 = xy2(1, sel) ;
    y2 = xy2(2, sel) ;    
    
%   Create A and b arrays
	A = create_A(x1, y1);
    b = reshape(cat(1, x2, y2), [], 1) ;
   
%   Solve for transformation parameters    
    trans_pars = pinv(A)*b;
    
%   Transform coordinates from image 1
    xy1_t = A * trans_pars;
    disp(size(xy1_t));
    
%   Calculate euclidean distances
    b = reshape(b, 2, []) ;
    xy1_t = reshape(xy1_t, 2, []);  
    euc_dists = sum((xy1_t - b).^2);
    
%   Calculate number of inliers
    inliers = euc_dists < r;
    num_inliers = sum(inliers);
    
%   Update best transformation parameters   
    if num_inliers > max_num_inliers
        best_trans_pars = trans_pars ;
        x1_best_inliers = x1(inliers) ;
        y1_best_inliers = y1(inliers) ;
        x2_best_inliers = x2(inliers) ;
        y2_best_inliers = y2(inliers) ;        
    end
end

% Recalculate transformation parameters using only the best inliers
A_best = create_A( x1_best_inliers, y1_best_inliers );
b_best = reshape(cat(1, x2_best_inliers, y2_best_inliers), [], 1) ;
best_trans_pars = pinv(A_best)*b_best ; 
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

% function [assignment] = find_nn( x,y, x_keypoints, y_keypoints )
% % Assigns point in image to index of nearest keypoint
% min_dist = 0;
% 
% for i=1:size(x_keypoints, 3)
%     x_kp = x_keypoints(:, :, i);
%     y_kp = y_keypoints(:, :, i);
%     euc_dist = ((x - x_kp)^2 + (y - y_kp)^2)^(1/2);
%     if euc_dist <= min_dist
%         assignment = i;
%     end
% end
% end
