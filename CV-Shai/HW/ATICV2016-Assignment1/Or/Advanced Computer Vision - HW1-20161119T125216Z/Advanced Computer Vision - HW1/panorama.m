function [ img_pan ] = panorama(img_src, img_dst, mp_src, mp_dst, inliers_percent, max_err)

    % computing the homography H :
    H = compute_homography(mp_src, mp_dst, inliers_percent, max_err);
    
    % get bounding box
    [r, c, d] =  size(img_dst);
    I_merged = img_dst;

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
    
    % initializing offset
    r_offset=0;
    c_offset=0;
    
    if upper_bound <= 0
        I_merged  = [zeros(abs(upper_bound) + 1, c, d); I_merged];
        [r, c, d] = size(I_merged);
        r_offset  = abs(upper_bound) + 1
    end
    if lower_bound  > r
        I_merged = [I_merged; zeros(lower_bound - r, c, d)];
        [r, c, d] = size(I_merged);
    end
    if left_bound <= 0
        I_merged = [zeros(r, abs(left_bound) + 1, d), I_merged];
        c_offset = abs(left_bound) + 1
        [r, c, d] = size(I_merged);
    end
    if right_bound > c
         I_merged = [I_merged, zeros(r, right_bound - c, d)];
        [r, c, d] = size(I_merged);
    end

    
    % Backward mapping:
    img_pan = backward_mapping(H, img_src, I_merged, r_offset, c_offset);
    [r_dst, c_dst, d_dst] =  size(img_dst)
    [r, c, d] =  size(img_pan)
    
    r_new_start=1+r_offset;
    r_new_end=r_offset+r_dst;
    c_new_start=1+c_offset;
    c_new_end=c_offset+c_dst;

    img_pan(r_new_start:r_new_end, c_new_start:c_new_end,:)=img_dst;
    

    
end

