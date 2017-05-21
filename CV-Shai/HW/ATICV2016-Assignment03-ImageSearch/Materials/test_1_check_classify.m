function test_1_check_classify()
    
    clear; clc; dbstop if error;
        
    % Load ground truth and test data
    ground_truth = load('ground_truth.mat');
    [class_hist, images_hist] = test_init('class_hist', 'images_hist');

    t = tic;
    
    % Merge all class histograms into matrix
    classes = fieldnames(ground_truth);
    code_size = size(class_hist.(classes{1}), 2);
    all_hists = zeros(numel(classes), code_size);
    for ic = 1:numel(classes)
        all_hists(ic,:) = class_hist.(classes{ic});
    end
    
    % Init counters
    ngood = 0;
    nbad = 0;
    
    % Identify all images of all classes (good+ok)
    for ic = 1:numel(classes)
        
        % Get current class name
        cur_fn = classes{ic};
        
        fprintf('\n\n%s\n-----------------\n', cur_fn);
        
        % Get images of current class
        cur_imgs = vertcat(ground_truth.(cur_fn).good, ground_truth.(cur_fn).ok);
        n_img = numel(cur_imgs);
        
        % Identify each image
        for k = 1:n_img
            
            % Get preloaded image feature histogram
            cur_hist = images_hist.(cur_imgs{k});
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Classify current image
            class_id = classify_hist(cur_hist, all_hists);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            fprintf('%15s == %s [%i]\n', cur_imgs{k}, classes{class_id}, class_id);
            
            % Update counters
            if class_id == ic
                ngood = ngood + 1;
            else
                nbad = nbad + 1;
            end
        end
    end
    
    fprintf('\n\nGood: %0.0f\nBad: %0.0f\nSuccess Rate: %0.2f%%\nRun Time: %0.2f [Sec]\n\n', ngood, nbad, 100*ngood/(ngood+nbad), toc(t))
end