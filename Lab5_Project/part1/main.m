% run from folder 'part1'
data = read_data()
[vocab_set, train_sets, test_set] = separate_data(data)
vocab = build_vocab(vocab_set, 50);
train_histos = cell([1, 4]);
for i = 1:4
    train_histos{i} = translate(train_set{i}, vocab);
end
%SVM_models = train(traini_histos, vocab);
%test_histos = translate(test_set, vocab); % Gaat niet werken door labels
%MAP = evaluate(test_histos, SVM_models, vocab);

%%

clc; close all;
test_img = data{1}{1}{5} ;
h = get_histogram( test_img, vocab ) ;
bincounts = h.Values ;