function [label_no_smooth] = naive_labeling(ssdd)

    [~, label_no_smooth] = min(ssdd,[],3);

%     [nRows, nCols,nLabels]=size(ssdd);
%     label_no_smooth=zeros(nRows,nCols);
%     dsp_range=floor(nLabels/2);
%     dsp_full_range = -dsp_range:dsp_range;
%     for m=1:nRows
%         for n=1:nCols
%         [min_val, index]=min(ssdd(m,n,:));
%          label_no_smooth(m,n)=index;
%         end
%     end
end

