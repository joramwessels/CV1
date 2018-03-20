function data = read_data(folder)
    % returns the full dataset structured such that
    % dimension 1 determines train (1) or test(2) set
    % dimension 2 determines airplanes (1), cars (2), faces (3), or
    %      motorbikes (4)
    % dimension 3 determines the image index
    
    if ~exist('folder', 'var')
        folder = '../Caltech4/ImageData/';
    end
    
    classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
    train_imgs = [500, 465, 400, 500];
    test_imgs  = [50, 50, 50, 50];
    
    train_data = cell(1, length(classes));
    test_data = cell(1, length(classes));
    for i = 1:length(classes)
        class = classes{i};
        
        path = strcat(folder, class, '_train/');
        class_train = cell(1, train_imgs(i));
        for j = 1:train_imgs(i)
            image = imread(strcat(path, 'img', sprintf('%03d', j), '.jpg'));
            if size(image, 3) == 3
                image = rgb2gray(image);
            end
            if isa(image, 'integer')
                image = im2single(image);
            end
            class_train{j} = image;
        end
        
        path = strcat(folder, class, '_test/');
        class_test = cell(1, test_imgs(i));
        for j = 1:test_imgs(i)
            image = imread(strcat(path, 'img', sprintf('%03d', j), '.jpg'));
            if size(image, 3) == 3
                image = rgb2gray(image);
            end
            if isa(image, 'integer')
                image = im2double(image);
            end
            class_test{j} = image;
        end
        
        train_data{i} = class_train;
        test_data{i}  = class_test;
    end
    data = {train_data, test_data};
end