clc; clear; close all;
k_values = [400, 800, 1600, 2000, 4000] ;
sift_meths = {'keypoints', 'dense'} ;
data = read_data() ;
[vocab_set, train_sets, test_sets] = separate_data(data) ;

for i=1:length(k_values)

    % Set the number of clusters
    n_clusters = k_values(i) ;
    
    for j=1:length(sift_meths)
        
        sift_meth = sift_meths{j} ;
        
        fprintf('\n\nGenerating features using %s SIFT and k=%d....\n\n', sift_meth, n_clusters)  
        
        vocab = build_vocab(vocab_set, n_clusters, sift_meth);
        train_histos = cell([1, 4]);
        test_histos  = cell([1, 4]);
        for i = 1:4
            train_histos{i} = translate(train_sets{i}, vocab);
            test_histos{i}  = translate(test_sets{i}, vocab);
        end

        % Save the vocab array
        filename_vocab = sprintf('vocabs_%s_%d.mat', sift_meth, n_clusters) ;
        save(filename_vocab, 'sift_meth')

        % Save train histograms
        filename_vocab = sprintf('train_histos_%s_%d.mat', sift_meth, n_clusters) ;
        save(filename_vocab, 'train_histos')

        % Save test histograms
        filename_vocab = sprintf('test_histos_%s_%d.mat', sift_meth, n_clusters) ;
        save(filename_vocab, 'test_histos')
        end
end