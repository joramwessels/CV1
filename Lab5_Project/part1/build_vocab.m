function vocab = build_vocab(vocab_set, vocab_size, sift_meth)
    % returns a vocabulary of cluster means, i.e. a list
    % of cluster means where the index is its ID.
    
    if ~exist('vocab_size','var')
        vocab_size = 400;
    end
    
    if ~exist('sift_meth','var')
        sift_meth = 'keypoints' ;
    end
    
    fprintf('Building vocab using %s SIFT...\n', sift_meth);
    
    descriptors = [];
    for i = 1:length(vocab_set)
        if strcmp(sift_meth, 'keypoints')
            [~, D] = vl_sift(vocab_set{i});
        elseif strcmp(sift_meth, 'dense')
            [~, D] = vl_dsift(vocab_set{i});
        else
            fprintf('SIFT method "%s" not recognized.\n', sift_meth)
        end
        descriptors = cat(1, descriptors, D.');
    end
    descriptors = double(descriptors);
    [~, means] = kmeans(descriptors, vocab_size, 'Distance', 'sqeuclidean', 'MaxIter', 500);
    vocab = means;
end