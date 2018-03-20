function [vocab_set, train_sets, test_set] = separate_data(data);
    % returns a mixed set for the vocab creation, four separate sets
    % for the training procedure, and a labeled test set {histo, class}
    fprintf('Separating data into sets...')
    
    vocab_set = data{1}{1}(1:(250));
    vocab_set = cat(2, vocab_set, data{1}{2}(1:232));
    vocab_set = cat(2, vocab_set, data{1}{3}(1:200));
    vocab_set = cat(2, vocab_set, data{1}{4}(1:250));
    
    train_sets = {data{1}{1}(250:500), data{1}{2}(232:465)
                  data{1}{3}(200:400), data{1}{4}(250:500)};
    
    test_set = cell([1, 200]);
    for i = 0:3
        for j = 1:50
            test_set{i*50+j} = {data{2}{i+1}{j}, i+1};
        end
    end
    
end