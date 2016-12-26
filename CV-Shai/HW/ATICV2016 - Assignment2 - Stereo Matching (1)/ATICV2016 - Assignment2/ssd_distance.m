function [ssdd] = ssd_distance_bkp (im_left, im_right, win_size, dsp_range)

    % initialize ssdd matrix:
    dsp_full_range = -dsp_range:dsp_range;
    [nRows, nCols] = size(im_left);
    nLabels=2*dsp_range + 1;
    window = ones(win_size);
    ssdd=zeros(nRows, nCols, nLabels);
    
    % Input images are rectified => x-axis search only
    im_right_padded = zeros(nRows,nCols+nLabels-1);
    im_right_padded(:,dsp_range+1:dsp_range+nCols) = im_right;

    for i = 1:nLabels
        % Shift im_right in the current disparity
        shift_im_right = im_right_padded(:,dsp_range+1+dsp_full_range(i):dsp_range+1+dsp_full_range(i)+nCols-1);
        % Perform conv2 with the square diff matrix.
        	ssdd(:,:,i) = conv2( (shift_im_right - im_left(:,:)).^2, window, 'same');
    end

    % Normalization
    ssdd = 255 * ( ssdd - min(ssdd(:)) ) / ( max(ssdd(:)) - min(ssdd(:)) );


end

