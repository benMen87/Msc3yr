function slice = get_slice26(C, slice_idx, flip)
    
    %slice_idx - -1 is the first diag under the main diag
    %             1 is the first diag right to the main diag
    [~, ~, d] = size(C);
    slice = zeros([d, length(diag(C(:,:,1), slice_idx))]);
    
    for i=1:d
        slice(i,:) = diag(C(:,:,i), slice_idx);
    end
    
    if flip
        slice = fliplr(slice);
    end
end