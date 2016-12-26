function [ H ] = haar(s)
%haar - calculate haar transform matrix.
%   INPUT: s - id image 
%   OUTPUT: H - haar transform matrix

%%
    H = 1;
    mother_psi = [1, 1];
    mother_fi  =  [1, -1];
    level = 1;
    s = 2^ceil(log2(s));
    while level < s
     H = [kron(H, mother_psi); ...
         kron(eye(level), mother_fi)] * 1/sqrt(2);
     level = level * 2;
    end

end

