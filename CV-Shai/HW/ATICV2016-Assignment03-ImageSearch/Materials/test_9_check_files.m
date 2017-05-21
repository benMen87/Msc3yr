function test_9_check_files()
    
    % Load files
    loaded_brief_coordinates = load('my_brief_coordinates.mat');
    loaded_code_book = load('my_code_book.mat');
    loaded_class_hist = load('my_class_hist.mat');
    
    % Check brief coordinates
    assert(isfield(loaded_brief_coordinates, 'brief_coordinates'), 'BRIEF Coordinates was not saved in ''brief_coordinates'' variable!');
    brief_coordinates = loaded_brief_coordinates.brief_coordinates;
    assert(size(brief_coordinates, 1) == 4, 'brief_coordinates must have 4 rows!');
    brief_size = size(brief_coordinates, 2);
    
    % Check code book
    assert(isfield(loaded_code_book, 'code_book'), 'Codebook was not saved in ''code_book'' variable!');
    code_book = loaded_code_book.code_book;
    assert(islogical(code_book), 'code_book must be matrix of type ''logical''!')
    assert(size(code_book, 2) == brief_size, 'Number of columns in code_book must be equal to the size of BRIEF Coordinate!')
    code_book_size = size(code_book, 1);
    
    % Check class histograms
    assert(isfield(loaded_class_hist, 'class_hist'), 'Class histograms was not saved in ''class_hist'' variable!');
    class_hist = loaded_class_hist.class_hist;
    assert(isstruct(class_hist), 'class_hist must be of type ''struct''!');
    mandatory_fields = {'all_souls', 'ashmolean', 'balliol', 'bodleian', ...
                        'christ_church', 'cornmarket', 'hertford', 'keble', ...
                        'magdalen', 'pitt_rivers', 'radcliffe_camera'};
    for ifn = 1:numel(mandatory_fields)
        cur_fn = mandatory_fields{ifn};
        assert(isfield(class_hist, cur_fn), sprintf('class_hist must contain mandatory field ''%s''!', cur_fn));
        cur_hist = class_hist.(cur_fn);
        assert(size(cur_hist, 1) == 1, sprintf('Class ''%s'' histogram is not a row vector!', cur_fn));
        assert(size(cur_hist, 2) == code_book_size, sprintf('Class ''%s'' histogram size must be equal to code book size!', cur_fn));
    end
    
    fprintf('Files test passed successfully!!!\n');
    
end