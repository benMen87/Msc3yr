function data_creator()
    
    %% Create Params
    
    p_dRange = 20; % Disparity lookup range (in pixels)
    p_WinSize = 3; % SSD window size
    p_Cost1 = 0.5; % Penalty cost of disparity distance = 1
    p_Cost2 = 3; % Penalty cost of disparity distance > 1
    
    save('my_params.mat', 'p_dRange', 'p_WinSize', 'p_Cost1', 'p_Cost2');
    
    
    %% Create input images from animated gif
    
    % Select image type
    image_type = 'animated_gif'; % for animated gif
    %image_type = 'rgb_image'; % for jpg, bmp, etc.
    %image_type = 'index_image'; % for gif, tiff, etc.
    
    switch image_type
        
        case 'animated_gif'

            input_image = 'GIF_ANIMATION_FILE_NAME';
            frame_left = 1;
            frame_right = 2;

            [img, cmap] = imread(input_image);
            im_left = ind2rgb(img(:,:,1,frame_left), cmap);
            im_right = ind2rgb(img(:,:,1,frame_right), cmap);
        
        case 'rgb_image'
        
            input_image_left = 'LEFT_IMAGE_FILE_NAME';
            input_image_right = 'RIGHT_IMAGE_FILE_NAME';
            
            im_left = imread(input_image_left);
            im_right = imread(input_image_right);
            
        case 'index_image'
            
            input_image_left = 'LEFT_IMAGE_FILE_NAME';
            input_image_right = 'RIGHT_IMAGE_FILE_NAME';
            
            [im_tmp, cmap] = imread(input_image_left);
            im_left = ind2rgb(im_tmp(:,:,1,1), cmap);
            [im_tmp, cmap] = imread(input_image_right);
            im_right = ind2rgb(im_tmp(:,:,1,1), cmap);
            
    end
    
    imwrite(im_left, 'my_image_left.png');
    imwrite(im_right, 'my_image_right.png');


end