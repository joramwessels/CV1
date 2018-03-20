function histograms = translate(train_set, vocab)
    histograms = zeros([length(train_set), length(vocab)]);
    for i = 1:length(train_set)
        histograms(i, :) = get_histogram(train_set(i), vocab);
    end
end