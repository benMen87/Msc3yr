function test_5_create_brief()
    
    clear; clc; dbstop if error;
    
    % Load ground truth and test data
    ground_truth = load('ground_truth.mat');
    [path_images, images_corner, brief_coordinates] ... =
        = test_init('path', 'images_corner', 'brief_coordinates');
    
    t = tic();
    
    % Get images list
    images_list = get_images_list(ground_truth);
    
    % Calculate BRIEF Descriptors for images
    images_brief = struct();
    ns = numel(images_list);
    for is = 1:ns
        
        % Get current image name
        cur_image = images_list{is};
        
        fprintf('% 3.0f/%0.0f: %23s  ', is, ns, cur_image);
        
        % Load image
        img_color = imread(fullfile(path_images, strcat(cur_image, '.jpg')));
        img = im2double(rgb2gray(img_color));
        
        % Get current interest points
        cur_corners = images_corner.(cur_image);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Build BRIEF Descriptor
        brief_descs = describe_interest_points(img, cur_corners, brief_coordinates);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Store BRIEF Descriptor
        images_brief.(cur_image) = brief_descs;
        
        fprintf(' !\n');
    end
    
    % Print results
    fprintf('\nRun Time: %0.2f [Sec]\n\n', toc(t))
    
    % Compress descriptors
    fprintf('Compressing BRIEF Descriptors...\n');
    for is = 1:ns
        cur_image = images_list{is};
        if islogical(images_brief.(cur_image))
            images_brief.(cur_image) = bin2int(images_brief.(cur_image));
        end
    end
    
    % Prompt to save result
    save('tmp_last_images_brief.mat', 'images_brief');
    msg1 = sprintf('Would you like to save the result?');
    msg2 = '(Saving images_brief to ''tmp_images_brief.mat'')';
    reply = questdlg({msg1,msg2},'Save Result','Yes','No','Yes');
    if strcmp(reply, 'Yes')
        save('tmp_images_brief.mat', 'images_brief');
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