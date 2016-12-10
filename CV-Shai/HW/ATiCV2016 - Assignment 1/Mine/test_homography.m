function [fit_percent, dist_mse] = test_homography(H, mp_src, mp_dst, ...
                                                  max_err)
%test_homography test quality of matching point
%   

dist = mp_dst - hom2cart((H*cart2hom(mp_src')')')';
err = sqrt(sum(dist.^2));
err = err(err > max_err);

fit_percent = 1- (length(err) / length(mp_src));
if isempty(err) == 0
    dist_mse = 0;
else
    dist_mse = sum(err) / length(err);
end
end

