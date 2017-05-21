function [I_merged] = forward_mapping( I_src, I_dst, H)
%forward_mapping Merge two images using matrix H as fowerd mapping

%get bounding box
[r, c, d] =  size(I_dst);
I_merged = I_dst;
r_offset = 0;
c_offset = 0;

ul = H*[1,1,1]';
ul = ul(1:2)./ul(3);

ll = H*[1,r,1]';
ll = ll(1:2)./ll(3);

ur = H*[c, 1, 1]';
ur = ur(1:2)./ur(3);

lr = H*[c,r,1]';
lr = lr(1:2)./lr(3);

upper_bound = floor(min(ul(2), ur(2)));
lower_bound = ceil(max(ll(2), lr(2)));
left_bound  = floor(min(ul(1), ll(1)));
right_bound  = ceil(min(ur(1), lr(1)));

if upper_bound <= 0
    I_merged  = [zeros(abs(upper_bound) + 1, c, d); I_merged];
    [r, c, d] = size(I_merged);
    r_offset  = abs(upper_bound) + 1;
end
if lower_bound  > r
    I_merged = [I_merged; zeros(lower_bound - r, c, d)];
    [r, c, d] = size(I_merged);
end
if left_bound <= 0
    I_merged = [zeros(r, abs(left_bound) + 1, d), I_merged];
    c_offset = abs(left_bound) + 1;
    [r, c, d] = size(I_merged);
end
if right_bound > c
     I_merged = [I_merged, zeros(r, right_bound - c, d)];
    [r, c, d] = size(I_merged);
end

[r_src, c_src, d_src] = size(I_src);

for x = 1 : c_src
    for y = 1 : r_src
        homo_corr = H*[x;y;1];
        x_new = homo_corr(1)/homo_corr(3) + c_offset;
        y_new = homo_corr(2)/homo_corr(3) + r_offset;
        
        if x_new <= 0 || y_new <= 0 || x_new > c || y_new > r
            continue
        end
        I_merged(ceil(y_new), ceil(x_new),:) = I_src(y, x, :);
        
    end
end

end

