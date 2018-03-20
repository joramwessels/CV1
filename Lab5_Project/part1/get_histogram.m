function norm_histogram = get_histogram( im, vocab )
% GET_HISTOGRAM: encodes image in histogram of visual words
% INPUT:
%   im: image array
%   vocab: mxn array with m=#features and n=sift dims
% OUTPUT:
%   histogram: visual word counts for given image
    
%   Detect SIFT features for image
    [F_im, D_im] = vl_sift(im) ;
    n_features = size(F_im, 2) ;
    
%   Check number of cluster centroids
    cluster_centroids = vocab ;
    n_clusters = size(vocab, 1) ; 
    
%   Initialize histogram counts
    histogram = zeros(1, n_clusters) ;
    
    % Assign cluster means for each feature descriptor
    for i=1:n_features
        
        min_dist = Inf ;
        assigned_cluster = -1 ;
        
        % Find closest cluster mean
        for j=1:n_clusters
            
            descriptor_i = D_im(:, i) ;
            cc_j = cluster_centroids(j, :) ;
            
            % Calculate euclidian distance between cluster mean and
            % descriptor
            dist = pdist([descriptor_i ; cc_j], 'euclidian') ;
            
            if dist < min_dist
                assigned_cluster = j ;
                min_dist = dist ;
            end
        end
        
        % Add count for cluster mean to histogram
        histogram(:, j) = histogram(:, j) + 1 ;
    end
    
% Normalize histogram
norm_histogram = histogram ./ n_features ; 
end