function varargout = test_init(varargin)
    
    % Load test data
    test_data = load('test_data.mat');
    
    % Assign data to outputs
    varargout = cell(1, nargin);
    for k = 1:nargin
        cur_arg = varargin{k};
        switch cur_arg
            case 'path'
                varargout{k} = prompt_for_path();
            otherwise
                varargout{k} = test_data.(varargin{k});
        end
    end
end


function path_img = prompt_for_path()
    
    % Init stored image path
    persistent last_path
    if isempty(last_path)
        last_path = cd;
    end
    
    % Prompt for images path
    path_img = uigetdir(last_path, 'Select Images Folder');
    if isempty(path_img) || isnumeric(path_img)
        error('CVApps:CancelledByUser', '\nCancelled by user.');
    end
    last_path = path_img;
end