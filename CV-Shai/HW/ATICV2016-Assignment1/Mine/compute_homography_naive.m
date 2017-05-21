function H = compute_homography_naive(mp_src, mp_dst)
%compute_homography_naive - computes homography transform (matrix H) given
%                           matching points.
%   INPUT:
%     mp_src - 2Xn for all matching src points [[r;c],[r;c]...] 
%     mp_src - 2Xn for all matching dst points [[r;c],[r;c]...] 

N = size(mp_dst, 2);
A  = zeros(2*N, 9);

for i = 0 : N -1 
    
   xs = mp_src(1, i + 1); 
   ys = mp_src(2, i + 1);
   xd = mp_dst(1, i + 1); 
   yd = mp_dst(2, i + 1);

   A(2*i + 1, :)     = [xs, ys, 1, 0, 0, 0, -xd*xs, -xd*ys, -xd];
   A(2*i + 2, :) = [0, 0, 0, xs, ys, 1, -yd*xs, -yd*ys, -yd];
   
end
[U,S,V] = svd(A);
%last eigenvector corisponds to lowes eigenvalue
H = V(:, 9);

end

