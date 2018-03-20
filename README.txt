LIBLINEAR Usage
=====

matlab> model = train(training_label_vector, training_instance_matrix [,'liblinear_options', 'col']);

        -training_label_vector:
            An m by 1 vector of training labels. (type must be double)
        -training_instance_matrix:
            An m by n matrix of m training instances with n features.
            It must be a sparse matrix. (type must be double)
        -liblinear_options:
            A string of training options in the same format as that of LIBLINEAR.
        -col:
            if 'col' is set, each column of training_instance_matrix is a data instance. Otherwise each row is a data instance.

matlab> [predicted_label, accuracy, decision_values/prob_estimates] = predict(testing_label_vector, testing_instance_matrix, model [, 'liblinear_options', 'col']);
matlab> [predicted_label] = predict(testing_label_vector, testing_instance_matrix, model [, 'liblinear_options', 'col']);

        -testing_label_vector:
            An m by 1 vector of prediction labels. If labels of test
            data are unknown, simply use any random values. (type must be double)
        -testing_instance_matrix:
            An m by n matrix of m testing instances with n features.
            It must be a sparse matrix. (type must be double)
        -model:
            The output of train.
        -liblinear_options:
            A string of testing options in the same format as that of LIBLINEAR.
        -col:
            if 'col' is set, each column of testing_instance_matrix is a data instance. Otherwise each row is a data instance.
