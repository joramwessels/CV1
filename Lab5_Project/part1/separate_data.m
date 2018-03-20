function [vocab_set, train_sets, test_set] = separate_data(data);
    % returns a mixed set for the vocab creation, four separate sets
    % for the training procedure, and a labeled test set {histo, class}
    fprintf('Separating data into sets...')
    
    vocab_set = data{1}{1}(1:(250));
    vocab_set = cat(2, vocab_set, data{1}{2}(1:232));
    vocab_set = cat(2, vocab_set, data{1}{3}(1:200));
    vocab_set = cat(2, vocab_set, data{1}{4}(1:250));
    
    train_sets = cell([1, 4]);
    train_sets{1} = data{1}{1}(250:500);
    train_sets{2} = data{1}{2}(232:465);
    train_sets{3} = data{1}{3}(200:400);
    train_sets{4} = data{1}{4}(250:500);
    
    test_set = data{2};
    
end