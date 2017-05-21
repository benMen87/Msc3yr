function [ L_slice ] = dp_grade_slice (C_slice, P1, P2)
    
    [nLabels, nCols]=size(C_slice);    
    L_silce=zeros(nLabels, nCols);

    % L_slice always gets atleast C_slice: L_slice(d,col)=C_slice(d,col)
    L_slice=C_slice;
    
    for col=2:nCols
        min_prev_col=min(L_slice(:,col-1));
        for d=1:nLabels
            % L(d,col-1)
            val1=L_slice(d,col-1);
            
            % min{L(d-1,col-1), L(d+1,col-1)}
            if (d==1)
                val2 = P1 + L_slice(d+1,col-1);
            elseif (d==nLabels)
                val2 = P1 + L_slice(d-1,col-1);
            else
                val2 = P1 + min( L_slice(d+1,col-1), L_slice(d-1,col-1) );
            end
            
            % min{L(d+k,col-1)} when k>=2
            if (d<=2)
                val3 = P2 + min( L_slice(d+2:end, col-1) );
            elseif (d>=(nLabels-1) )
                val3 = P2 + min( L_slice(1:d-2, col-1) );
            else
                val3 = P2 + min (min(L_slice(d+2:end, col-1)),...
                            min(L_slice(1:d-2, col-1)) );
            end
            M = min( val1, min(val2, val3) );
           
            L_slice(d,col) = L_slice(d,col) + M -min_prev_col;
        end
    end
end





