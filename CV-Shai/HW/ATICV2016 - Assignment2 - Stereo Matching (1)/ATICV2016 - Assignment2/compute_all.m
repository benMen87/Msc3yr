function compute_all(file_left_img, file_right_img, file_params)
    
    
    %% Initializing
    
    % Processing Parameters
    load(file_params)
    required_params = {'p_dRange', 'p_WinSize', 'p_Cost1', 'p_Cost2'};
    for ip = 1:numel(required_params)
        assert(exist(required_params{ip}, 'var') == 1, sprintf('%s is missing in params file', required_params{ip}));
    end
    num_labels = 2 * p_dRange + 1;
    
    % Read images
    rgb_left = imread(file_left_img);
    im_left = im2double(rgb2gray(rgb_left));
    rgb_right = imread(file_right_img);
    im_right = im2double(rgb2gray(rgb_right));
    
    % Draw images
    figure(101);
    subplot(1, 2, 1); imshow(im_left); title('Left Image');
    subplot(1, 2, 2); imshow(im_right); title('Right Image');
    
    
    %% SSD Distance matrix
    
    % Compute Sum-Square-Diff distance
    ssdd = ssd_distance(im_left, im_right, p_WinSize, p_dRange);
    
    
    %% Naive disparity image
    
    % Construct disparity image
    label_no_smooth = naive_labeling(ssdd);
    
    % Draw disparity image
    figure(102);
    subplot(1, 2, 1); imshow(rgb_left); title('Source Image');
    subplot(1, 2, 2);
    imshow(label_no_smooth, [1, num_labels]);
    colormap('jet'); title('Naive Depth');

    
    %% Smooth disparity image - Dynamic Programming
    
    % Construct disparity image
    label_smooth_dp = dp_labeling(ssdd, p_Cost1, p_Cost2);
    
    % Draw disparity image
    figure(103);
    subplot(1, 2, 1); imshow(rgb_left); title('Source Image');
    subplot(1, 2, 2);
    imshow(label_smooth_dp, [1, num_labels]);
    colormap('jet'); title('Smooth Depth - DP');
    
    
    %% Smooth disparity image - Semi-Global Mapping
    
    % Construct disparity image
    label_smooth_sgm = sgm_labeling(ssdd, p_Cost1, p_Cost2);
    
    % Draw disparity image
    figure(104);
    subplot(1, 2, 1); imshow(rgb_left); title('Source Image');
    subplot(1, 2, 2);
    imshow(label_smooth_sgm, [1, num_labels]);
    colormap('jet'); title('Smooth Depth - SGM');
    
    
    %% Final results
    
    figure(105);
    subplot(2, 2, 1); imshow(rgb_left); title('Source');
    subplot(2, 2, 2);
    imshow(label_no_smooth, [1, num_labels]);
    colormap('jet'); title('SSD');
    subplot(2, 2, 3);
    imshow(label_smooth_dp, [1, num_labels]);
    colormap('jet'); title(sprintf('DP (%0.1f,%0.1f)', p_Cost1, p_Cost2));
    subplot(2, 2, 4);
    imshow(label_smooth_sgm, [1, num_labels]);
    colormap('jet'); title(sprintf('SGM (%0.1f,%0.1f)', p_Cost1, p_Cost2));    
        
end