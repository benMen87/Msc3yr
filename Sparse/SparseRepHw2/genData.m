function [C_g, C_d, C_b,  D, T, x, y_d, y_g, y_b, y0]=genData(p,k,dr_ratio,D)
%GENDATA wrapper function for all gen*.m funcions
%   INPUT:
%       p     - fraction of collumns to sample (dim(C) = [p*s, s].
%       k     - support of X (y = CDx + noise).
%       sig_n - noise variance.
%       D     - Dictinary matrix, if D=[] haar matrix will be used.
%               dim(D) = s^2Xs^2 where length(X) = s^2.
%   OUTPUT:
%       C_g - smpling gaussian matrix.
%       C_d - sampling subtracted identity matrix.
%       D   - dictionary of which y = Dx.
%       T   - input signal acutal support indices.
%       x   - generated unnknown signal with support T.
%       y_d - y_d = C_dDX

    s = 32; 
    if isempty(D)
        D = sparse(haar2d(s))'; %sparse transpose of Haar transform 
    end

    [C_d,  C_g, C_b] = gen_sampling_matrices(s, p, D);
    T   = genT(s, k, s^2); % verify that n argument should be s^2
    x   = genX(T, s);
    y0  = genY0(s, x, D);
    dr  = max(y0) - min(y0);
    w1 	= (dr*dr_ratio) *  randn([p*s^2, 1]);
    w2 	= (dr*dr_ratio) *  randn([s^2, 1]);

    y_b = C_b * y0 + w2;
    y_d = C_d * y0 + w1;
    y_g = C_g * y0 + w1;

end
