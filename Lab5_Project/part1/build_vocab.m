function vocab = build_vocab(vocab_set, vocab_size, sift_meth, color_space)
    % returns a vocabulary of cluster means, i.e. a list
    % of cluster means where the index is its ID.
    
    if ~exist('vocab_size','var')
        vocab_size = 400;
    end
    
    if ~exist('sift_meth','var')
        sift_meth = 'keypoints' ;
    end
    
    if ~exist('color_space','var')
        color_space = 'grayscale' ;
    end
    
    fprintf('Generating visual vocabulary using %s-SIFT with %s features and k=%d...\n', color_space, sift_meth, vocab_size)      
    
    descriptors = [];
    for i = 1:length(vocab_set)
        image_i = vocab_set{i} ;
        
        if strcmp(color_space, 'grayscale')
            % Convert RGB images into grayscale if needed
            if size(image, 3) == 3
                image_i = rgb2gray(image_i) ;
            end
            
        elseif strcmp(color_space, 'RGB')
            % Create 3 identical color channels for grayscale images
            if size(image, 3) == 1
                image_i = repmat(image_i, 1, 1, 3) ;
            end
            
        elseif strcmp(color_space, 'rgb')
            % Create 3 identical color channels for grayscale images
            if size(image, 3) == 1
                image_i = repmat(image_i, 1, 1, 3) ;
            end
            
            % Convert to normalized rgb
            image_i = image_i ./ sum(image_1, 3) ;
            
        elseif strcmp(color_space, 'opponent')
            
            % Create 3 identical color channels for grayscale images
            if size(image, 3) == 1
                image_i = repmat(image_i, 1, 1, 3) ;
            end
            
            % Convert to opponent color space
            image_i = rgb2opponent(image_i) ;    
        end
       
        % Convert into single
        if not(isa(image_i, 'single'))
            image_i = single(image_i);
        end
        
        % Detect SIFT features for all color channels separately
        for j = 1:size(image_i, 3)
            if strcmp(sift_meth, 'keypoints')
                [~, D] = vl_sift(image_i(:, :, j)) ;
            elseif strcmp(sift_meth, 'dense')
                [~, D] = vl_dsift(image_i(:, :, j)) ;
            else
                fprintf('SIFT method "%s" not recognized.\n', sift_meth)
            end
            descriptors = cat(1, descriptors, D.');
        end
    
    end
    
    descriptors = double(descriptors);
    [~, means] = kmeans(descriptors, vocab_size, 'Distance', 'sqeuclidean', 'MaxIter', 500);
    vocab = means;
end