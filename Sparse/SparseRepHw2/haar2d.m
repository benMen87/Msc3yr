function [ H ] = haar2d(s)
%Haar2d - return collumn stack haar transform matrix 
%   INPUT:
%       s - signal dimention is sXs.
%   OUTPUT:
%       H - is s^2Xs^2 haar collumn stack transform matrix.

H1d = haar(s);
H = kron(H1d, H1d);

end

