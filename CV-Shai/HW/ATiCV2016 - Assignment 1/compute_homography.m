function H = compute_homography(mp_src, mp_dst, inliers_percent, max_err)
%compute_homography use ransac to compute homography
%   Detailed explanation goes here

inliners = 0;
points_count = length(mp_src);
n    = 4; %amount of random points to fit model 

while inliners < inliers_percent
    
    %choose n random point
    points = randi([1,points_count], 1, n);
    H = compute_homography_naive(mp_src(:, points), mp_dst(:, points));
    H = reshape(H, 3, 3)';
    [inliners, ~] = test_homography(H, mp_src, mp_dst, max_err);
end





end

