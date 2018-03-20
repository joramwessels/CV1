% run from folder 'part1'
data = read_data()

% vocab set is the first half of all training data
vocab_set = data{1}{1}(1:(250));
vocab_set = cat(1, vocab_set, data{1}{2}(1:232));
vocab_set = cat(1, vocab_set, data{1}{3}(1:200));
vocab_set = cat(1, vocab_set, data{1}{4}(1:250));

vocab = build_vocab(vocab_set, 50);