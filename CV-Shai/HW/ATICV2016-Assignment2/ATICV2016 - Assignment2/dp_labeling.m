function [ label_smooth_dp] = dp_labeling(C, P1, P2)
    
        [nRows, nCols, ~]=size(C); 
        label_smooth_dp=zeros(nRows, nCols);
       
        for row=1:nRows
             L_silce_h = dp_grade_slice (squeeze(C(row,:,:))', P1, P2);
            [~, label_smooth_dp(row,:)] = min(L_silce_h);
        end
        
         
end

