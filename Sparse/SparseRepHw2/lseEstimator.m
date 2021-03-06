function x_hat = lseEstimator(T, y, C, D)
%LSE Oracal reconstruction know support use Least squere errors
%   Detailed explanation goes here


[s, ~] = size(D);

x_hat = zeros([s, 1]);

A_T = full(C*D(:,T));
x_hat(T) = pinv(A_T' * A_T) * A_T' * y; %LSE solution

end