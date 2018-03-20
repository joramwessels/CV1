function histograms = translate(train_set, vocab)
    % translates the entire training set from images to histograms
    % returns a matrix of n_images x n_cluster_means
    print('Translating training set...')
    
    histograms = zeros([length(train_set), length(vocab)]);
    for i = 1:length(train_set)
        histograms(i, :) = get_histogram(train_set(i), vocab);
    end
end