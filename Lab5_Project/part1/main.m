%% Load data and separate into different sets
clc; close all;

data = read_data();
[vocab_set, train_sets, test_sets] = separate_data(data);

%% Demo of generating visual vocabulary
clc; close all;

vocab = build_vocab(vocab_set, 50);
n_classes = length(train_sets);
train_histos = cell([1, n_classes]);
test_histos  = cell([1, n_classes]);
for i = 1:n_classes
    train_histos{i} = translate(train_sets{i}, vocab);
    test_histos{i}  = translate(test_sets{i}, vocab);
end

%% Demo of training SVM using saved histograms
clc; close all;

load('train_histos_keypoints_400.mat') ;
size(train_histos)
load('test_histos_keypoints_400.mat') ;
models = train_models(train_histos);
MAP = evaluate(test_histos, models);

%%

clc; close all;
test_img = data{1}{1}{5} ;
h = get_histogram( test_img, vocab ) ;
bincounts = h.Values ;