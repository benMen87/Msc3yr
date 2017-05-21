function [ I_m] = mark_points( I, p)
%mark_points Given an image and point output new image with points marked
%   INPUT:
%   I - input image
%   p - 2Xn points to mark
%   OUTPUT:
%   I_m - original image with marked points

[r, c, d] = size(I);
match_p = sub2ind([r, c],p(2, :), p(1, :));
point_mask = ones([r, c], 'uint8');
I_m = zeros(size(I), 'uint8');

point_mask(match_p)  = 0; %mark in black points


for depth = 1: d
    I_m(:, :, depth) = I(:, :, depth) .* point_mask + 255*(d==1);%mark red
end


end

