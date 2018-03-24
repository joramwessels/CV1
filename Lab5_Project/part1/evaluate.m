function MAP = evaluate(test_histos, models)
    % evaluates the classifier and returns the mean average precision
    fprintf('Evaluating models...\n')
    
    % determining dimensions
    n_classes = length(models);
    n_samples = 0;
    for i = 1:n_classes
        th_size = size(test_histos{i});
        n_samples = n_samples + th_size(1);
    end
    
    % calculating scores
    labels = zeros([1, n_samples]);
    scores = zeros([n_samples, n_classes]);
    for i = 1:n_classes
        
        % preparing the test data into sets
        sets = cell([1, n_classes]);
        for j = 1:n_classes
            if i == j
                lbl = 1;
            else
                lbl = 0;
            end
            sets{j} = {test_histos{j}, lbl};
        end
        
        % predicting test data with binary SVM
        [test_labels, test_matrix] = prepare_liblinear_format(sets);
        labels = labels + test_labels*i;
        [pred, acc, prob] = predict(test_labels, test_matrix, models{i}, '-b 1');
        
        % fetching the probabilities for class '1'
        if test_labels(1) == 1
            col = 1;
        else
            col = 2;
        end
        scores(:, i) = prob.';%(:, col);
    
    end
    
    % calculating Mean Average Precision
    ranks = scores_to_ranks(scores);
    MAP = calculate_MAP(ranks, labels);
    
end

function ranks = scores_to_ranks(scores)
    % converts a list of scores into a list of rankings
    ranks = zeros(size(scores));
    for i = 1:length(scores)
        sorted = sort(scores(i, :), 'descend');
        for j = 1:length(sorted)
            ranks(i, j) = find(scores(i, :) == sorted(j));
        end
    end
end

function MAP = calculate_MAP(ranks, labels)
    % calculates the mean average precision for a list of rankings
    r_size = size(ranks);
    n_samples = r_size(1);
    n_classes = r_size(2);
    
    APs = zeros([1, n_samples]);
    for i = 1:n_samples
        % Average Precision of these rankings is always 1/rank * 1/classes
        ranking = ranks(i, :);
        rank_of_lbl = find(ranking == labels(i));
        APs(i) = (1/rank_of_lbl) * (1/n_classes);
    end
    MAP = mean(APs);
end