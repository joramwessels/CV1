function models = train_models(train_histos)
    % trains a binary model per class
    % for every class it creates a list of (matrix, label) tuples
    % where the label is 1 if it learns that class (i==j) and 0 otherwise
    fprintf('Training models...')
    
    n_classes = length(train_histos);
    models = cell([1, n_classes]);
    for i = 1:n_classes
        sets = cell([1, n_classes]);
        for j = 1:n_classes
            mtr = train_histos{j};
            if j == i
                lbl = 1;
            else
                lbl = 0;
            end
            sets{j} = {mtr, lbl};
        end
        models{i} = train_SVM(sets);
    end
end