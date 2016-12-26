function slice  = get_slice_direction(C, slice_direction, slice_idx)
%get_slice_direction  - get slices of ssdd matrix.
%   depending on direction get slices of C[dXnXm]- tensor of pixels per
%   disparity values. for diagnle directions indexing is used as 
%   library function `diag` uses.

if slice_direction == 1 || slice_direction == 5
    slice = get_slice15(C, slice_idx, slice_direction == 5);
elseif slice_direction == 2 || slice_direction == 6
    slice = get_slice26(C, slice_idx, slice_direction == 6);
elseif slice_direction == 3 || slice_direction == 7
    slice = get_slice15(permute(C, [2, 1, 3]), slice_idx, slice_direction == 7);
elseif slice_direction == 4 || slice_direction == 8
    slice = get_slice26(fliplr(C), slice_idx, slice_direction == 8);
    
    
end
end

function  slice = get_slice15(C, slice_idx, flip)
    slice = C(slice_idx, :, :);
    if flip
        slice = fliplr(slice);
    end
    slice = squeeze(slice)';
end

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