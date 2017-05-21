function test_4_create_features()
    
    clear; clc; dbstop if error;
        
    % Load test data
    [images_brief, code_book] = test_init('images_brief', 'code_book');
    
    t = tic();
    
    % Convert BRIEF Descriptors to feature vectors (word histograms)
    images_list = fieldnames(images_brief);
    images_hist = struct();
    ns = numel(images_list);
    all_hdist = cell(1,ns);
    for is = 1:ns
        
        % Get current image name
        cur_image = images_list{is};
        
        fprintf('% 3.0f/%0.0f: %23s  ', is, ns, cur_image);
        
        % Get current brief descriptor
        cur_briefs_compressed = images_brief.(cur_image);
        cur_briefs = int2bin(cur_briefs_compressed);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Build words list
        [words, hdist] = assign_to_cluster(cur_briefs, code_book);
        
        % Build feature vector
        feat_vec = build_feature_vector(words, code_book);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Store feature vector
        images_hist.(cur_image) = feat_vec;
        all_hdist{is} = hdist';
        
        fprintf(' [Distance from word: Avg:% 3.0f ; Std:% 3.0f ; Max:% 3.0f]\n', mean(hdist), std(hdist), max(hdist));
    end
    
    % Print results
    all_hdist = [all_hdist{:}];
    fprintf('\nFinal Results (include in document):');
    fprintf('\nTotal distance from word Avg: %0.0f\n', mean(all_hdist));
    fprintf('Total distance from word Std: %0.0f\n', std(all_hdist));
    fprintf('Total distance from word Max: %0.0f\n', max(all_hdist));
    fprintf('Run Time: %0.2f [Sec]\n\n', toc(t))
    
    % Prompt to save result
    save('tmp_last_images_hist.mat', 'images_hist');
    msg1 = sprintf('Would you like to save the result?');
    msg2 = '(Saving images_hist to ''tmp_images_hist.mat'')';
    reply = questdlg({msg1,msg2},'Save Result','Yes','No','Yes');
    if strcmp(reply, 'Yes')
        save('tmp_images_hist.mat', 'images_hist');
    end

end