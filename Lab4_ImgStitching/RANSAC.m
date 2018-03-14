function best_trans_pars = RANSAC(f1, f2, matches, N, P, disp_transfs)

% Parse input arguments
if nargin <5
    disp_transfs = true;
end

r = 10; % allowed radius for inliers
best_trans_pars = zeros(6,P);
max_num_inliers = 0;

for i=1:N
    
%     Randomly select P matches
    perm = randperm(size(matches,2)) ;
    sel = perm(1:P) ;
    matches = matches(:, sel) ;
    
%     Find corresponding x1, y1, x2, y2
    x1 = reshape(f1(1,matches(1,:)), [1,1,P]) ;
    x2 = reshape(f2(1,matches(2,:)), [1,1,P]) ;
    y1 = reshape(f1(2,matches(1,:)), [1,1,P]) ;
    y2 = reshape(f2(2,matches(2,:)), [1,1,P]) ;
    
%     DIT MOET OOK NOG ANDERSOM
    z1 = zeros(1, 1, P);
    o1 = ones(1, 1, P);
    A1 = cat(1, cat(2, x1, y1, z1, z1, o1, z1), cat(2, z1, z1, x1, y1, z1, o1));
    b2 = cat(1, x2, y2);
    
%   Solve for transformation parameters    
    for i=1:P
        trans_pars(:,i) = pinv(A1(:,:,i))*b2(:,:,i);
    end
    
    xy1_t = zeros(2, P);
    
%   Transform coordinates from image 1
    for i=1:P
        xy1_t(:, i) = A1(:,: , i) * trans_pars(:, i);
    end
    
%     Calculate euclidean distances
    euc_dists = (sum((xy1_t - b2).^2, 2)).^(1/2);
    
%     Calculate number of inliers
    num_inliers = sum(euc_dists(euc_dists < r));
    
    if num_inliers > max_num_inliers
        best_trans_pars = trans_pars;
    end
end

% Display transformations
% if disp_transfs
%     sprintf('Jode')
% end
end