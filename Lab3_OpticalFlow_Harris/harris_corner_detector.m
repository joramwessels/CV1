function [ H, r, c ] = harris_corner_detector( image, varargin )
gray_image = im2double(rgb2gray( image ));
[h, w, ~] = size( gray_image );

% initialization
r = [];
c  = [];

if nargin == 1
    sigma = 1;
    kernel_size = 5;
    thres = 1e-4;
    n = 9;
elseif nargin == 2
    thres = varargin{1};
    sigma = 0.5;
    kernel_size = 5;
    n = 9;
elseif nargin == 5
    sigma = varargin{1};
    kernel_size = varargin{2};
    thres = varargin{3};
    n = varargin{4};
else
    fprintf('Incorrect number of input arguments')
end

G1 = gauss2D( sigma, kernel_size );
[Gx,Gy] = gradient(G1);
Ix = imfilter( gray_image, Gx );
Iy = imfilter( gray_image, Gy );

G2 = gauss2D( 2.0, 7 );
A = imfilter( Ix.^2, G2 );
B = imfilter( Ix.*Iy, G2 );
C = imfilter( Iy.^2, G2 );
H = ( A.*C - B.^2 ) - 0.04*( A + C ).^2;

for i=1:w
    for j=1:h
        halfwidth = (n-1)/2;
        xmin = max([ 1, i - halfwidth ]);
        xmax = min([ w, i + halfwidth ]);
        ymin = max([ 1, j - halfwidth ]);
        ymax = min([ h, j + halfwidth ]);
        window = H( ymin:ymax, xmin:xmax );
        if (H( j, i ) == max(max( window ))) && (H( j, i) > thres)
            r = [ r, i ];
            c = [ c, j ];
        end
    end
end

figure
imshow(Ix)
figure
imshow(Iy)
figure
imshow(image)
hold on;
plot(r, c, 'rx', 'LineWidth', 2, 'MarkerSize', 15);
end