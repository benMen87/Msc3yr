function test_2_create_classes()
    
    clear; clc; dbstop if error;
    
    % Load ground truth and test data
    ground_truth = load('ground_truth.mat');
    [images_hist] = test_init('images_hist');
    
    t = tic;
        
    % Combine all images' feature histograms
    [sample_hists, class_ids] = combine_hists(images_hist, ground_truth);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Learn classes
    class_hist_combined = learn_classes(sample_hists, class_ids);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Separate class feature histograms
    class_hist = separate_hists(class_hist_combined, ground_truth); %#ok<NASGU>
    
    fprintf('Run Time: %0.2f [Sec]\n\n', toc(t));
    
    % Prompt to save result
    save('tmp_last_class_hist.mat', 'class_hist');
    msg1 = sprintf('Would you like to save the result?');
    msg2 = '(Saving class_hist to ''my_class_hist.mat'')';
    reply = questdlg({msg1,msg2},'Save Result','Yes','No','Yes');
    if strcmp(reply, 'Yes')
        save('my_class_hist.mat', 'class_hist');
    end
end


function [sample_hists, class_ids] = combine_hists(images_hist, ground_truth)
    % Combine all images' feature histograms
    classes = fieldnames(ground_truth);
    sample_hists = [];
    class_ids = [];
    for ic = 1:numel(classes)
        cur_class = classes{ic};
        
        % Extract current images
        cur_imgs = vertcat(ground_truth.(cur_class).good, ground_truth.(cur_class).ok);
        n_img = numel(cur_imgs);
        
        % Get code size
        code_size = size(images_hist.(cur_imgs{1}), 2);
        
        % Gather all histograms of current class
        cur_hists = zeros(n_img, code_size);
        cur_ids = zeros(n_img, 1);
        for k = 1:n_img
            cur_hists(k,:) = images_hist.(cur_imgs{k});
            cur_ids(k) = ic;
        end
        
        % Append current class histograms and ids
        sample_hists = [sample_hists ; cur_hists]; %#ok<AGROW>
        class_ids = [class_ids ; cur_ids]; %#ok<AGROW>
    end
end

function class_hist = separate_hists(class_hist_combined, ground_truth)
    % Separate class feature histograms
    classes = fieldnames(ground_truth);
    class_hist = struct;
    for ic = 1:numel(classes)
        cur_class = classes{ic};
        class_hist.(cur_class) = class_hist_combined(ic, :);
    end
end