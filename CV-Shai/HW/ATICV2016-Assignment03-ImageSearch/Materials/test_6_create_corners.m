function test_6_create_corners()
    
    clear; clc; dbstop if error;
    
    % Load ground truth and test data
    ground_truth = load('ground_truth.mat');
    [path_images] = test_init('path');
    
    % Parameters
    window_size = 21;
    max_points = 1000;
    
    t = tic();
    
    % Get images list
    images_list = get_images_list(ground_truth);
    
    % Find image corners
    images_corner = struct();
    ns = numel(images_list);
    for is = 1:ns
        
        % Get current image name
        cur_image = images_list{is};
        
        fprintf('% 3.0f/%0.0f: %23s  ', is, ns, cur_image);
        
        % Load image
        img_color = imread(fullfile(path_images, strcat(cur_image, '.jpg')));
        img = im2double(rgb2gray(img_color));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Find interest points
        cur_corners = find_interest_points(img, window_size/2, max_points);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Store interest points
        images_corner.(cur_image) = cur_corners;
        
        fprintf(' !\n');
    end
    
    % Print results
    fprintf('Run Time: %0.2f [Sec]\n\n', toc(t))
    
    % Prompt to save result
    save('tmp_last_images_corner.mat', 'images_corner');
    msg1 = sprintf('Would you like to save the result?');
    msg2 = '(Saving images_corner to ''tmp_images_corner.mat'')';
    reply = questdlg({msg1,msg2},'Save Result','Yes','No','Yes');
    if strcmp(reply, 'Yes')
        save('tmp_images_corner.mat', 'images_corner');
    end
    
end


function images_list = get_images_list(ground_truth)
    % Generate list of filenames used in ground_truth files
    classes = fieldnames(ground_truth);
    tmp_list = cell(1,numel(classes));
    for ic = 1:numel(classes)
        tmp_list{ic} = vertcat(ground_truth.(classes{ic}).good, ...
                                ground_truth.(classes{ic}).ok, ...
                                ground_truth.(classes{ic}).junk);
    end
    images_list = vertcat(tmp_list{:});
end