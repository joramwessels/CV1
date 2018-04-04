function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
  '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [1];



%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
folder = '../Caltech4/ImageData/';
train_imgs = [500, 465, 400, 500];
test_imgs  = [50, 50, 50, 50];
n_classes = length(classes);
n_images = sum(train_imgs) + sum(test_imgs);

data = zeros([32, 32, 3, n_images]);
lbls = zeros([1, n_images]);
sets = zeros([1, n_images]);

img_counter = 1;
for i = 1:n_classes
    class = classes{i};
    
    path = strcat(folder, class, '_train/');
    for j = 1:train_imgs(i)
        image = imread(strcat(path, 'img', sprintf('%03d', j), '.jpg'));
        
        image = imresize(image, [32, 32]);
        if isa(image, 'integer')
            image = im2single(image);
        end
        if size(image, 3) == 1
            image = cat(3, image, image, image);
        end
        
        data(:, :, :, img_counter) = image;
        lbls(img_counter) = i;
        sets(img_counter) = 1;
        img_counter = img_counter + 1;
    end
    
    path = strcat(folder, class, '_test/');
    for j = 1:test_imgs(i)
        image = imread(strcat(path, 'img', sprintf('%03d', j), '.jpg'));
        
        image = imresize(image, [32, 32]);
        if isa(image, 'integer')
            image = im2double(image);
        end
        if size(image, 3) == 1
            image = cat(3, image, image, image);
        end
        
        data(:, :, :, img_counter) = image;
        lbls(img_counter) = i;
        sets(img_counter) = 2;
        img_counter = img_counter + 1;
    end
    
end
%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(lbls) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
