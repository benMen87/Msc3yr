function [ L_slice ] = dp_grade_slice (C_slice, P1, P2)
    
    [nLabels, nCols]=size(C_slice);    
    

    % L_slice always gets atleast C_slice: L_slice(d,col)=C_slice(d,col)
    L_slice=C_slice;
    L_slice_pad = [inf*ones([1,nCols]); L_slice; inf*ones([1,nCols])];
    
    for col=2:nCols
        min_prev_col=min(L_slice(:,col-1));
        % L(d,col-1)
        val1 = L_slice_pad(2:end-1,col-1);
        val2 = P1 + min( L_slice_pad(3:end,col-1),...
        L_slice_pad(1:end-2,col-1) );
            
        % min{L(d+k,col-1)} when k>=2
        val3 = (P2 + min (L_slice_pad(:, col - 1)))*ones([nLabels,1]);
        M = min(min(val1, val2), val3);
        L_slice_pad(2:end-1,col) = L_slice_pad(2:end-1,col) + M -min_prev_col;
    end
    L_slice = L_slice_pad(2:end-1,:) ;
end





