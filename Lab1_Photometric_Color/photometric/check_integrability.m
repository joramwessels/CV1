function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

[h, w, ~] = size(normals);

% initalization
p = zeros(h,w);
q = zeros(h,w);
SE = zeros(h,w);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

p = normals(:,:,1)./normals(:,:,3);
q = normals(:,:,2)./normals(:,:,3);


% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE


py = zeros(size(p));
qx = zeros(size(q));

% Estimate second-order derivatives using central difference
for x=2:w-1
    qx(:,x) = (q(:,x+1) - q(:,x-1))/2;
end

for y=2:h-1
    py(y,:) = (q(y+1,:) - q(y-1,:))/2;
end 

SE = (py - qx)^2;

% ========================================================================




end

