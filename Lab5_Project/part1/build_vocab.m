function vocab = build_vocab(vocab_set, vocab_size)
    % returns a vocabulary of cluster means, i.e. a list
    % of cluster means where the index is its ID.
    fprintf('Building vocab...');
    
    if ~exist('vocab_size','var')
        vocab_size = 400;
    end
    
    descriptors = [];
    for i = 1:length(vocab_set)
        [F, D] = vl_sift(vocab_set{i});
        descriptors = cat(1, descriptors, D.');
    end
    descriptors = double(descriptors);
    [idx, means] = kmeans(descriptors, vocab_size, 'Distance', 'sqeuclidean');
    vocab = means;
end