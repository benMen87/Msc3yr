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

    global S;
    
    if isempty(D)
        D = sparse(haar2d(S))'; %sparse transpose of Haar transform 
    end
    
    
   [C_d,  C_g, C_b] = gen_sampling_matrices(S, p, D);
   A = 0;
   i = 0;
   while(any(all(A == 0)))
        T   = genT(S, k, S^2); % verify that n argument should be s^2
        A = C_d*D(:, T);
        disp(i);
        i = i + 1;
   end
   
   
    x   = genX(T, S);
    y0  = genY0(x, D);
    dr  = max(y0) - min(y0);
    w1 	= (dr*dr_ratio) *  randn([floor(p*S^2), 1]);
    w2 	= (dr*dr_ratio) *  randn([floor(S^2), 1]);

    y_b = C_b * y0 + w2;
    y_d = C_d * y0 + w1;
    y_g = C_g * y0 + w1;

end
