function model = train_SVM(sets)
    matrix_cat = sets{1}{1};
    msize  = size(matrix_cat);
    label_cat = ones([msize(1), 1]) * sets{1}{2};
    for i = 2:length(sets)
        matrix = sets{i}{1};
        msize  = size(matrix);
        label  = ones([msize(1), 1]) * sets{i}{2};
        matrix_cat = cat(1, matrix_cat, matrix);
        label_cat  = cat(1, label_cat, label);
    end
    model = train(label_cat, sparse(matrix_cat));
end