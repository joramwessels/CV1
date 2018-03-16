function xy = transform_img( img1, trans_pars, transf_meth )
    
    if nargin < 3
        transf_meth = 'builtin' ;
    end
    
    [h, w, ~] = size(img1) ;
    
    if strcmp(transf_meth, 'builtin')
        fprintf('Not implemented')
    elseif strcmp(transf_meth, 'nn')
        [Y, X] = ndgrid(1:h, 1:w) ;
        xy = cat(2, X(:), Y(:)) ;
        xy_t = zeros(size(xy)) ;
        
        for i=1:length(xy)
            xi = xy(i, 1) ;
            yi = xy(i, 2) ;
            Ai = create_A( xi, yi ) ;
            xy_t(i, :) ;
        end
    else
        sprintf('Image transformation method "%s" not recognized.', transf_meth)
    end
end