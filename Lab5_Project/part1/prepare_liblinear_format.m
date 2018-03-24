function [labels, matrix] = prepare_liblinear_format(sets)
    % Converts the list of sets into a single vector and sparse matrix
    % the 'sets' input is a list of tuples, each of which has a matrix
    % of mxn observations at index 1, and their label at index 2
    % the output is a list of model structs
    
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
    labels = label_cat;
    matrix = sparse(matrix_cat);
end