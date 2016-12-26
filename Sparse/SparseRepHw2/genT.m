function T = genT(s, k, n)
%GEN_T generate the truth support of X
%   INPUT: 
%       s - X is sXs matrix.
%       k - support size of X.
%       n - support index i lives in {1..n}.
%   OUTPUT:
%       T - support of X.

    T = randperm((s/4)*(s/4+1),min(ceil(k/2),40));
    T = mod(T,s/4) + s*(floor(T/(s/4)));
    while length(T) < k
        T = unique([T, randperm(n,k-length(T))]);
    end
end