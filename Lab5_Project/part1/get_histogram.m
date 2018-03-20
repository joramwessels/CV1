function h = get_histogram( im, vocab )
% GET_HISTOGRAM: encodes image in histogram of visual words
% INPUT:
%   im: image array
%   vocab: mxn array with m=#features and n=sift dims
% OUTPUT:
%   histogram: histogram object
    
%   Image preprocessing
    if not (size(im, 3) == 1)
        im = rgb2gray(im) ;
    end
    if not(isa(im, 'single'))
        im = single(im) ;
    end

%   Detect SIFT features for image
    [F_im, D_im] = vl_sift(im) ;
    n_features = size(F_im, 2) ;
    
%   Check number of cluster centroids
    cluster_centroids = vocab ;
    n_clusters = size(vocab, 1) ; 
    
%   Initialize histogram counts
    assignments = zeros(1, n_features) ;
    
    % Assign cluster means for each feature descriptor
    for i=1:n_features
        
        min_dist = Inf ;
        assigned_cluster = -1 ;
        
        % Find closest cluster mean
        for j=1:n_clusters
            
            descriptor_i = double(D_im(:, i)) ;
            cc_j = cluster_centroids(j, :) ;
            
            % Calculate euclidian distance between cluster mean and
            % descriptor
            dist = pdist([descriptor_i' ; cc_j], 'squaredeuclidean') ;
            
            if dist < min_dist
                assigned_cluster = j ;
                min_dist = dist ;
            end
        end
        assignments(:, i) = assigned_cluster ;
        
    end
    
    % Create histogram for cluster assignments
    h = histogram(assignments, 'Normalization', 'probability') ;
end