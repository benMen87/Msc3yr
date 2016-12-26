function x = genX(T, s)
%GEN_X genenrate random X of size 1XS^2 with support of T
%   INPUT:
%       T - x support holds indices of x that are none zero.
%       s - size of the the image martix x (sXs).
%   OUTPUT:
%       x - generated x.

    x = zeros([s^2, 1]);
    mu  = 0;
    sigma = 1;

    x(T) = mu + sigma.*randn(size(T));
end