% run from folder 'part1'
data = read_data();
[vocab_set, train_sets, test_sets] = separate_data(data);
vocab = build_vocab(vocab_set, 50);
n_classes = length(train_sets);
train_histos = cell([1, n_classes]);
test_histos  = cell([1, n_classes]);
for i = 1:n_classes
    train_histos{i} = translate(train_sets{i}, vocab);
    test_histos{i}  = translate(test_sets{i}, vocab);
end
models = train_models(train_histos);
MAP = evaluate(test_histos, models);

%%

clc; close all;
test_img = data{1}{1}{5} ;
h = get_histogram( test_img, vocab ) ;
bincounts = h.Values ;