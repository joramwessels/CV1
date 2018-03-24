function [labels, scores] = classify(test_histos, models)
    % classifies the image histograms and returns the labels and scores
    
    n_classes = length(models);
    sets = cell([1, n_classes]);
    for i = 1:n_classes
        sets{i} = {test_histos{i}, i};
    end
    [test_labels, test_matrix] = prepare_liblinear_format(sets);
    
    scores = zeros([length(test_labels), n_classes]);
    labels = zeros([length(test_labesl), 1]);
    for i = 1:n_classes
        [pred, acc, prob] = predict(test_labels, test_matrix, models{i});
        %scores(:, i) = prob; % more complicated than this, check README
        labels = labels + pred * i;
    end
end